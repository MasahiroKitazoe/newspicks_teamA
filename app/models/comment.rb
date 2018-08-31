class Comment < ApplicationRecord
  belongs_to :pick
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  validates :pick_id, presence: true

  def do_like(user)
    likes.create(user_id: user.id)
  end

  def undo_unlike(user)
    likes.find_by(user_id: user.id).destroy
  end
end
