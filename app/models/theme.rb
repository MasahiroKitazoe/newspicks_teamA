class Theme < ApplicationRecord
  has_many :picks, through: :picks_themes
  has_many :picks_themes
end
