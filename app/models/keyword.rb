class Keyword < ApplicationRecord
  belongs_to :user

  validates :keyword, presence: true
  validates :keyword,  uniqueness: { scope: :user_id }
end
