class AddIndexCommentsUserId < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, [:user_id, :pick_id], unique: true
  end
end
