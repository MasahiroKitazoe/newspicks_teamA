class CreatePickThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :pick_themes do |t|

      t.timestamps
    end
  end
end
