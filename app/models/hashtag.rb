class Hashtag < ApplicationRecord
  REGEXP = /#[\w-]+/

  has_many :hashtags_questions
  has_many :questions, through: :hashtags_questions

  validates :name, uniqueness: { case_sensitive: false }

  def to_param
    name
  end
end
