class Pick < ApplicationRecord
  validates :url, :image, :title, :body, null: false

  def self.get_article_info(url)
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

    # 画像とsourceを取得
    img_meta = ""
    source_meta = ""
    elements = page.search('meta')
    elements.each do |ele|
      if ele.get_attribute('property') == "og:image"
        img_meta = ele
      elsif ele.get_attribute('property') == "og:site_name"
        source_meta = ele
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
      results[:source] = url.match(/http[s]:\/\/([\w.]+)\//)[1]
    end

    # bodyを取得
    results[:body] = ""
    if page.search('p')
      texts = page.search('p')
      i = 0
      while results[:body].length <= 40
        results[:body] = results[:body] + texts[i]
        i += 1
      end
    else
      results[:body] = "本文は表示できません"
    end

    return results
  end
end
