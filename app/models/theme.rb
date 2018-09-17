class Theme < ApplicationRecord
  has_many :pick_themes
  has_many :picks, through: :pick_themes
end
