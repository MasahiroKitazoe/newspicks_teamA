class Dislike < ApplicationRecord
  belongs_to :disliker, class_name: "User"
  belongs_to :disliked_id, class_name: "User"
  validates :disliker, presence: true
  validates :disliked_ind, presence: true
end
