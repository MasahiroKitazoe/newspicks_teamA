class CreatePickThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :pick_themes do |t|
      t.references :pick, foreign_key: true
      t.timestamps :theme, foreign_key: true
    end
  end
end
