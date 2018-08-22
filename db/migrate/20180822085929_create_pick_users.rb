class CreatePickUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :pick_users do |t|

      t.timestamps
    end
  end
end
