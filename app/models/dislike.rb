class Dislike < ApplicationRecord
  belongs_to :disliker, class_name: "User"
  belongs_to :disliked, class_name: "User"
  validates :disliker_id, presence: true
  validates :disliked_id, presence: true
end
