class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(google)

  has_many :comments
  has_many :keywords
  has_many :pick_users
  has_many :picks, through: :pick_users
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes
  has_many :active_dislikes, class_name: "Dislike",
                             foreign_key: "disliker_id",
                             dependent: :destroy
  has_many :passive_dislikes, class_name: "Dislike",
                              foreign_key: "disliked_id",
                              dependent: :destroy
  has_many :disliking, through: :active_dislikes, source: :disliked
  has_many :dislikers, through: :passive_dislikes, source: :disliker

  mount_uploader :image, ImageUploader

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def liked?(comment)
    if likes.find_by(comment_id: comment.id)
      return true
    else
      return false
    end
  end

  class << self
    def get_like_ids_within_one_week
      tg_likes = Like.where(created_at: [7.days.ago..Time.now])
      tg_likes.map { |like| like.id }
    end

    def get_comments_liked_within_one_week
      grouped_likes = Like.group(:comment_id).where(created_at: [7.days.ago..Time.now])
      comment_ids = grouped_likes.map { |like| like.comment_id }
    end

    def create_user_likes_hash(like_ids, comment_ids)
      user_likes = {}
      target_comments = Comment.where(id: comment_ids)
      target_comments.each do |comment|
        likes_count = comment.likes.where(id: like_ids).count
        if user_likes[comment.user_id].nil?
          user_likes[comment.user_id] = likes_count
        else
          user_likes[comment.user_id] += likes_count
        end
      end
      user_likes
    end

    def get_sorted_users_and_likes(user_likes, limit_num)
      target_users = []
      weekly_likes = []
      len_counter = 0
      user_likes.each do |key, val|
        target_users << User.find(key)
        weekly_likes << val
        len_counter += 1
        break if len_counter >= limit_num
      end
      return target_users, weekly_likes
    end

    def rank_user(limit_num)
      #1週間以内にlikeされたコメントを取り出し、user_idでグループ化、keyがuser_id、valがlike数のハッシュを生成
      user_likes = create_user_likes_hash(get_like_ids_within_one_week, get_comments_liked_within_one_week)

      #Like数の多い順にハッシュをソート
      user_likes.sort_by {|k,v| -v}

      #like数の多い順にユーザーを取り出す
      target_users, weekly_likes = get_sorted_users_and_likes(user_likes, limit_num)
    end
  end

  def dislike(other_user)
    disliking << other_user
  end

  def undislike(other_user)
    active_dislikes.find_by(disliked_id: other_user.id).destroy
  end

  def disliking?(other_user)
    disliking.include?(other_user)
  end

  def show_follow_link
    "/follow/#{self.id}"
  end

  def show_unfollow_link
    "/unfollow/#{self.id}"
  end

  protected
  # ユーザーのGoogleメールアドレスからユーザーを検索
  # 登録ずみユーザーはGoogleアカウントと関連付け
  # 未登録ユーザーはGoogleアカウント情報からユーザー登録
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.access_token = auth.credentials.token
      return user
    else
      user = User.create(first_name: auth.info.first_name,
                         email: auth.info.email,
                         last_name:  auth.info.last_name,
                         provider:   auth.provider,
                         uid:        auth.uid,
                         access_token: auth.credentials.token,
                         password: Devise.friendly_token[0, 20])
      return user
    end
  end

end
