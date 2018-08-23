class CreateKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords do |t|
      t.string :keyword, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
