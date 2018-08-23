class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|
      t.string :url, null: false, index: true
      t.string :image, null: false
      t.string :title, null: false, index: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
