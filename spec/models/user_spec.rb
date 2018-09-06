require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'test on rank users' do

    before do
      @likes = []
      @comments = []
      10.times { @comments << FactoryBot.create(:comment) }
      5.times { @likes << FactoryBot.create(:like) }
      @like = FactoryBot.create(:like, created_at: 10.days.ago)
    end

    it 'gets accurate length of like ids array' do
      like_ids_within_one_week = User.get_like_ids_within_one_week
      expect(like_ids_within_one_week.length).to eq 5
    end

    it 'does not include like id that is outdated' do
      like_ids_within_one_week = User.get_like_ids_within_one_week
      expect(like_ids_within_one_week).to_not include(@like.id)
    end

    it 'gets accurate length of comment ids array' do
      commnet_ids = @likes.map { |like| like.comment_id }
      comment_ids_liked_within_one_week = User.get_comments_liked_within_one_week
      expect(comment_ids_liked_within_one_week.length).to eq 5
    end

    it 'does not include comment id that is liked over a week ago' do
      comment_ids_liked_within_one_week = User.get_comments_liked_within_one_week
      expect(comment_ids_liked_within_one_week).to_not include(@like.comment_id)
    end

    it 'gets accurate length of hash that indicates the set of user id and like counts' do
      like_ids_within_one_week = User.get_like_ids_within_one_week
      comment_ids_liked_within_one_week = User.get_comments_liked_within_one_week
      user_likes = User.create_user_likes_hash(like_ids_within_one_week, comment_ids_liked_within_one_week)
      expect(user_likes.size).to eq 5
    end

    it 'gets arrays of user id that has limited length' do
      user_ranking, weekly_likes = User.rank_user(3)
      expect(user_ranking.length).to eq 3
    end

    it 'gets arrays of likes counts that has limited length' do
      user_ranking, weekly_likes = User.rank_user(3)
      expect(weekly_likes.length).to eq 3
    end

    context 'gets array of likes counts that is arranged in descending order' do

      before do
        3.times { FactoryBot.create(:like, comment_id: @comments[0].id) }
        2.times { FactoryBot.create(:like, comment_id: @comments[1].id) }
        @user_ranking, @weekly_likes = User.rank_user(5)
      end

      it 'has bigger first element than second one' do
        expect(@weekly_likes[0]).to be > @weekly_likes[1]
      end

      it 'has bigger second element than third one' do
        expect(@weekly_likes[1]).to be > @weekly_likes[2]
      end
    end
  end
end
