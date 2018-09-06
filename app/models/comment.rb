class Comment < ApplicationRecord
  belongs_to :pick
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  validates :pick_id, presence: true

  def do_time(comment)
    Time.now - comment.created_at
  end

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

  def self.get_comment_id_within_one_week
    Comment.where(created_at: [7.days.ago..Time.now]).ids
  end

  def self.get_popular_comments(target_ids, limit_num)
    ids = Like.group(:comment_id).where(comment_id: target_ids).order('count_comment_id DESC').limit(limit_num).count(:comment_id).keys
    ranking = ids.map { |id| Comment.find(id) }
  end

  def self.get_popular_comment_all_time(limit_num)
    ids = Like.group(:comment_id).order('count_comment_id DESC').limit(limit_num).count(:comment_id).keys
    ranking =  ids.map { |id| Comment.find(id) }
    if ranking.length == 0
      ranking = Comment.order('created_at DESC').limit(limit_num)
    end
    return ranking
  end

  def self.rank_comment(limit_num)
    #1週間以内のCommentのidを取得
    target_ids = get_comment_id_within_one_week

    #Like数の多いコメントを取得
    ranking = get_popular_comments(target_ids, limit_num)

    #該当commentが0件のとき、代わりに時期無制限でlikeの多いcommentを取得
    if ranking.length == 0
      ranking = get_popular_comment_all_time(limit_num)
    end
    return ranking
  end
end
