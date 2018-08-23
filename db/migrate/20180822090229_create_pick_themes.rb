class CreatePickThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :pick_themes do |t|
      t.references :pick, foreign_key: true

      t.references :theme, foreign_key: true
      t.timestamps
    end
  end
end
