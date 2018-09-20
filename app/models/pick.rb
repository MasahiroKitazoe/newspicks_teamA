class Pick < ApplicationRecord
  validates :url, :image, :title, :body, presence: true

  has_many :comments, dependent: :destroy
  has_many :pick_users
  has_many :users, through: :pick_users
  has_many :themes, through: :pick_themes
  has_many :pick_themes
  has_many :check_users, through: :comments, source: :user

  def self.get_article_info(url)
    agent = Mechanize.new()
    results = {}
    page = agent.get(url)

    # metaタグを取得
    title_meta = ""
    img_meta = ""
    source_meta = ""
    elements = page.search('meta')
    elements.each do |ele|
      if ele.get_attribute('property') == "og:image"
        img_meta = ele
      elsif ele.get_attribute('property') == "og:site_name"
        source_meta = ele
      elsif ele.get_attribute('property') == "og:title"
        title_meta = ele
      end
    end

    # 記事タイトルを取得
    if title_meta.present?
      if title_meta.get_attribute('content')
        results[:title] = title_meta.get_attribute('content')
      end
    else
      if page.at('h1')
        results[:title] = page.at('h1').inner_text
      elsif page.at('h2')
        results[:title] = page.at('h2').inner_text
      elsif page.at('h3')
        results[:title] = page.at('h3').inner_text
      elsif page.at('h4')
        results[:title] = page.at('h4').inner_text
      elsif page.at('h5')
        results[:title] = page.at('h5').inner_text
      elsif page.at('title')
        results[:title] = page.at('title').inner_text
      else
        results[:title] = 'タイトルが見つかりませんでした'
      end
    end

    #画像の格納
    if img_meta.present?
      if img_meta.get_attribute('content')
        results[:image] = img_meta.get_attribute('content')
      end
    else
      results[:image] = "https://lh3.googleusercontent.com/VVhNlcQA_r1FP-T09tiSPdASiiBAYsQ7jw0StynJmoIzqy1BxteCOJtlh_fXzl-_JCUNj0inwj-MM7-EYgeR3ObcihckA-FjK_CUrmGzIsEGYJfiyBhOH4JDftzEfPEFxFm-3ycY4lQ=w853-h570-no"
    end

    # sourceの格納
    if source_meta.present?
      if source_meta.get_attribute('content')
        results[:source] = source_meta.get_attribute('content')
      end
    else
      results[:source] = url.match(/https?:\/\/([-_\w.]+)\//)[1]
    end

    # bodyを取得
    results[:body] = ""
    if page.search('p')
      texts = page.search('p')
      i = 0
      while texts[i] && results[:body].length <= 40
        results[:body] += texts[i]
        i += 1
      end
    end

    if results[:body] == (nil || "")
      results[:body] = "本文は表示できません"
    end

    return results
  end

  def upcheck(user)
    comments.find_by(user_id: user.id).update
  end

  def check?(user)
    check_users.include?(user)
  end

  def self.categorize(text)
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse("https://serene-crag-46893.herokuapp.com/classify/text_logreg")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump(text: text)

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    result = response.body
    res_num = result[1].to_i
    res_num + 1
  end

  def get_pickers(excluded_user)
    pickers = self.comments.map { |comment| comment.user }
    pickers.delete(excluded_user)
    pickers
  end

  def get_popular_comment
    target_ids = self.comments.ids
    ids = Like.group(:comment_id).where(comment_id: target_ids).order('count_comment_id DESC').limit(1).count(:comment_id).keys
    if ids[0].nil?
      comments = self.comments.order('created_at DESC')
      result = ""
      comments.each do |comment|
        if comment.comment.present?
          result = comment
          break
        end
      end
      if result.class == String && result.empty?
        "コメントはまだありません"
      else
        result
      end
    else
      Comment.find(ids[0])
    end
  end
end
