class CreateDislikes < ActiveRecord::Migration[5.1]
  def change
    create_table :dislikes do |t|
      t.integer :disliker_id
      t.integer :disliked_id

      t.timestamps
    end
    add_index :dislikes, :disliker_id
    add_index :dislikes, :disliked_id
    add_index :dislikes, [:disliker_id, :disliked_id], unique: true
  end
end
