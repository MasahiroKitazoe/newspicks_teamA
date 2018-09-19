class PickTheme < ApplicationRecord
  belongs_to :pick
  belongs_to :theme

class << self
  def register_theme(pick, text)
    theme_id = Pick.categorize(text)
    pick_theme = PickTheme.new(pick_id: pick.id, theme_id: theme_id)
    pick_theme.save
  end
end
end
