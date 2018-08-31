class Comment < ApplicationRecord
  belongs_to :pick
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  validates :pick_id, presence: true

  def do_like(user)
    likes.create(user_id: user.id, comment_id: self.id)
  end

  def undo_like(user)
    likes.find_by(user_id: user.id).destroy
  end

  def get_like_id
    like = likes.find_by(comment_id: self.id)
    return like.id
  end
end
