class Pick < ApplicationRecord
  validates :url, :image, :title, :body, null: false

  def get_article_info(url)
    
  end
end
