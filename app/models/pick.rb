class Pick < ApplicationRecord
  validates :url, :image, :title, :body, null: false

  def get_article_info(url)
    agent = Mechanize.new()
    results = {}
    page = agent.get(url)

    # 記事タイトルを取得
    if page.at('h1').inner_text
      results[:title] = page.at('h1').inner_text
    elsif page.at('h2').inner_text
      results[:title] = page.at('h2').inner_text
    elsif page.at('h3').inner_text
      results[:title] = page.at('h3').inner_text
    elsif page.at('h4').inner_text
      results[:title] = page.at('h4').inner_text
    elsif page.at('h5').inner_text
      results[:title] = page.at('h5').inner_text
    else
      results[:title] = page.at('title').inner_text
    end

    # 画像を取得
    img_meta = ""
    elements = page.search('meta')
    elements.each do |ele|
      if ele.get_attribute('property') == "og:image"
        img_meta = ele
      end
    end
    if img_meta
      if img_meta.get_attribute('content')
        results[:image] = img_meta.get_attribute('content')
      else
        results[:image] = "https://lh3.googleusercontent.com/VVhNlcQA_r1FP-T09tiSPdASiiBAYsQ7jw0StynJmoIzqy1BxteCOJtlh_fXzl-_JCUNj0inwj-MM7-EYgeR3ObcihckA-FjK_CUrmGzIsEGYJfiyBhOH4JDftzEfPEFxFm-3ycY4lQ=w853-h570-no"
      end
    end

    # bodyを取得
    if page.at('p').inner_text
      results[:body] = page.at('p').inner_text
    end

    return results
  end

  def check(user)
    comment.create(user_id: user.id)
  end

  def uncheck(user)
    comment.find_by(user_id: user.id).destroy
  end

  def check?(user)
    check_users.include?(user)
  end

  def
  has_many :comments, dependent: :destroy
  has_many :users, through: :pick_users
  has_many :pick_users
  has_many :themes, through: :pick_themes
  has_many :pick_themes
  has_many :check_users, through: :picks, source: :user
end
