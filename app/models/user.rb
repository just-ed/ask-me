class User < ApplicationRecord
  validates :email, :username, presence: true, uniqueness: true
end
