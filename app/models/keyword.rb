class Keyword < ApplicationRecord
  belongs_to :user

  validates :keyword,  uniquness: { scope: :user_id  }
end
