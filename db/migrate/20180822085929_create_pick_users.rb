class CreatePickUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :pick_users do |t|
      t.references :pick, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
