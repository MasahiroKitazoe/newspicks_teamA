require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'test on rank comments' do
    context 'when comments made past one week exists' do
      before do
        @comments = []
        @comment = FactoryBot.create(:comment, created_at: 10.days.ago)
        10.times { @comments << FactoryBot.create(:comment) }
      end

      it 'does not include outdated comments' do
        target_ids = Comment.get_comment_id_within_one_week
        expect(target_ids).to_not include(@comment.id)
      end

      it 'gets accurate length of comment id array' do
        target_ids = Comment.get_comment_id_within_one_week
        expect(target_ids.length).to eq 10
      end

      it 'gets popular comments within one week' do
        3.times { FactoryBot.create(:like, comment_id: @comments[0].id) }
        2.times { FactoryBot.create(:like, comment_id: @comments[1].id) }
        FactoryBot.create(:like, comment_id: @comments[2].id)

        target_ids = Comment.get_comment_id_within_one_week
        ranking = Comment.get_popular_comments(target_ids, 10)
        expect(ranking.length).to eq 3
      end
    end

    context 'when comments made past one week do not exists' do
      before do
        @comments = []
        10.times { @comments << FactoryBot.create(:comment, created_at: 10.days.ago) }
      end

      it 'does not detect comments within one week' do
        target_ids = Comment.get_comment_id_within_one_week
        expect(target_ids.length).to eq 0
      end

      it 'does not get updated popular comments' do
        target_ids = Comment.get_comment_id_within_one_week
        ranking = Comment.get_popular_comments(target_ids, 10)
        expect(ranking.length).to eq 0
      end

      it 'gets popular comments from all time' do
        3.times { FactoryBot.create(:like, comment_id: @comments[0].id) }
        2.times { FactoryBot.create(:like, comment_id: @comments[1].id) }
        FactoryBot.create(:like, comment_id: @comments[2].id)

        ranking = Comment.get_popular_comment_all_time(5)
        expect(ranking.length).to eq 3
      end

      context 'when no likes added' do
        it 'gets newest comments when no updated and liked comments exists' do
          ranking = Comment.get_popular_comment_all_time(10)
          expect(ranking.length).to eq 10
        end
      end
    end
  end
end
