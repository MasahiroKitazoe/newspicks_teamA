class Comment < ApplicationRecord
  belongs_to :pick
  belongs_to :user
  has_many :likes
end
