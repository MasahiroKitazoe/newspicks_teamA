FactoryBot.define do
  factory :pick do
    url { "https://ledge.ai/atn-vol1-report/" }
    image { "https://s3-ap-northeast-1.amazonaws.com/ledge-assets/media/wp-content/uploads/2018/05/30135315/ai-talknight-vol1-top.jpg" }
    title { "キカガク吉崎氏を招いた「AI TALK NIGHT vol.1 “これってAIでできますか？”」イベントレポート" }
    body { "『THE AI 2nd』 一部企業講演資料公開3月22日にレッジが開催した、「これってAIでできますか？」をテーマにAIのスペシャリストを招いて夜な夜な語るイベント「AI TALK NIGHT」vol.1。第一回から大変盛況をいただきました。" }
    source { "Ledge.ai" }
  end
end
