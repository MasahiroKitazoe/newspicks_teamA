class Comment < ApplicationRecord
  belongs_to :pick
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  validates :pick_id, presence: true
end
