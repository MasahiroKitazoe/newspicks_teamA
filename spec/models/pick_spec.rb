require 'rails_helper'

RSpec.describe Pick, type: :model do

  describe 'test on model validation' do

    it 'is valid with url, image, title, body' do
      pick = FactoryBot.build(:pick)
      expect(pick).to be_valid
    end

    it 'is invalid without url' do
      pick = FactoryBot.build(:pick, url: nil)
      pick.valid?
      expect(pick.errors[:url]).to include("を入力してください")
    end

    it 'is invalid without image' do
      pick = FactoryBot.build(:pick, image: nil)
      pick.valid?
      expect(pick.errors[:image]).to include("を入力してください")
    end

    it 'is invalid without title' do
      pick = FactoryBot.build(:pick, title: nil)
      pick.valid?
      expect(pick.errors[:title]).to include("を入力してください")
    end

    it 'is invalid without body' do
      pick = FactoryBot.build(:pick, body: nil)
      pick.valid?
      expect(pick.errors[:body]).to include("を入力してください")
    end
  end

  describe 'test on scraping method' do

    it 'detects all information from the site scraped' do
      url = "https://ledge.ai/atn-vol1-report/"
      results = {title: "キカガク吉崎氏を招いた「AI TALK NIGHT vol.1 “これってAIでできますか？”」イベントレポート", image: "https://s3-ap-northeast-1.amazonaws.com/ledge-assets/media/wp-content/uploads/2018/05/30135315/ai-talknight-vol1-top.jpg", body: "『THE AI 2nd』 一部企業講演資料公開3月22日にレッジが開催した、「これってAIでできますか？」をテーマにAIのスペシャリストを招いて夜な夜な語るイベント「AI TALK NIGHT」vol.1。第一回から大変盛況をいただきました。", source: "Ledge.ai"}
      expect(Pick.get_article_info(url)).to eq results
    end

    context 'when scraping the site which gives incomplete information' do

      it 'does not get title data from the site scraped' do
        url = "https://flask-deploy-sample.herokuapp.com/"
        results = Pick.get_article_info(url)
        expect(results[:title]).to eq "タイトルが見つかりませんでした"
      end

      it 'does not get image data from the site scraped' do
        url = "https://flask-deploy-sample.herokuapp.com/"
        results = Pick.get_article_info(url)
        expect(results[:image]).to eq "https://lh3.googleusercontent.com/VVhNlcQA_r1FP-T09tiSPdASiiBAYsQ7jw0StynJmoIzqy1BxteCOJtlh_fXzl-_JCUNj0inwj-MM7-EYgeR3ObcihckA-FjK_CUrmGzIsEGYJfiyBhOH4JDftzEfPEFxFm-3ycY4lQ=w853-h570-no"
      end

      it 'does not get source data from the site scraped' do
        url = "https://flask-deploy-sample.herokuapp.com/"
        results = Pick.get_article_info(url)
        expect(results[:source]).to eq "flask-deploy-sample.herokuapp.com"
      end

      it 'does not get body data from the site scraped' do
        url = "https://www.flickr.com/"
        results = Pick.get_article_info(url)
        expect(results[:body]).to eq "本文は表示できません"
      end

      it 'gets not-enough body data(less than 40 characters) from the site scraped' do
        url = "https://flask-deploy-sample.herokuapp.com/"
        results = Pick.get_article_info(url)
        expect(results[:body]).to eq "OK!"
      end

    end

  end

end
