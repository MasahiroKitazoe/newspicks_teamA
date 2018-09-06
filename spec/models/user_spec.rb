require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#rank_user' do

    before do
      @comments = FactoryBot.create_list(:comment, 10)
      @likes = FactoryBot.create_list(:like, 5)
      @like = FactoryBot.create(:like, created_at: 10.days.ago)
    end

    it 'returns arrays of user id that have limited length' do
      user_ranking, weekly_likes = User.rank_user(3)
      expect(user_ranking.length).to eq 3
    end

    it 'returns array of likes counts that has limited length' do
      user_ranking, weekly_likes = User.rank_user(3)
      expect(weekly_likes.length).to eq 3
    end

    describe '#get_like_ids_within_one_week' do
      it 'returns accurate length of like ids array?' do
        like_ids_within_one_week = User.get_like_ids_within_one_week
        expect(like_ids_within_one_week.length).to eq 5
      end

      it 'does not return outdated like ids array?' do
        like_ids_within_one_week = User.get_like_ids_within_one_week
        expect(like_ids_within_one_week).to_not include(@like.id)
      end
    end

    describe '#get_comments_liked_within_one_week' do
      it 'returns accurate length of comment ids array?' do
        commnet_ids = @likes.map { |like| like.comment_id }
        comment_ids_liked_within_one_week = User.get_comments_liked_within_one_week
        expect(comment_ids_liked_within_one_week.length).to eq 5
      end

      it 'does not return outdated comment ids array?' do
        comment_ids_liked_within_one_week = User.get_comments_liked_within_one_week
        expect(comment_ids_liked_within_one_week).to_not include(@like.comment_id)
      end
    end

    describe '#create_user_likes_hash' do
      it 'returns accurate length of hash that indicates the set of user id and like counts?' do
        like_ids_within_one_week = User.get_like_ids_within_one_week
        comment_ids_liked_within_one_week = User.get_comments_liked_within_one_week
        user_likes = User.create_user_likes_hash(like_ids_within_one_week, comment_ids_liked_within_one_week)
        expect(user_likes.size).to eq 5
      end
    end

    context 'when arranging in descending order' do

      before do
        FactoryBot.create_list(:like, 3, comment_id: @comments[0].id)
        FactoryBot.create_list(:like, 2, comment_id: @comments[1].id)
        @user_ranking, @weekly_likes = User.rank_user(5)
      end

      it 'returns bigger first element than second one?' do
        expect(@weekly_likes[0]).to be > @weekly_likes[1]
      end

      it 'returns bigger second element than third one?' do
        expect(@weekly_likes[1]).to be > @weekly_likes[2]
      end
    end
  end

  context 'when making relationship links' do
    before do
      @user = FactoryBot.create(:user)
    end

    describe '#show_follow_link' do
      it 'returns an accurate follow link' do
        follow_link = @user.show_follow_link
        expect(follow_link).to eq "/follow/#{@user.id}"
      end
    end

    describe '#show_unfollow_link' do
      it 'returns an accurate unfollow link' do
        unfollow_link = @user.show_unfollow_link
        expect(unfollow_link).to eq "/unfollow/#{@user.id}"
      end
    end
  end
end
