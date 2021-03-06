require 'openssl'

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions, dependent: :destroy
  has_many :authored_questions, class_name: 'Question', foreign_key: 'author_id', dependent: :nullify

  validates :username,
            presence: true,
            uniqueness: true,
            length: { maximum: 40 },
            format: { with: /\A[\w]+\z/ }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            presence: true, on: :create,
            confirmation: true

  validates :bg_color, format: { with: /\A#([\da-f]{3}){1,2}\z/i }, allow_blank: true

  before_validation :downcase_username
  before_save :encrypt_password

  def downcase_username
    self.username = username.downcase
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(
              password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end
