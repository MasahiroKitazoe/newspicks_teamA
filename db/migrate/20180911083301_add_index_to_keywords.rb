class AddIndexToKeywords < ActiveRecord::Migration[5.1]
  def change
    add_index :keywords, [:keyword, :user_id], unique: true
  end
end
