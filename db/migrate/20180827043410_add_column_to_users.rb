class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :access_token, :string

    add_index :users, [:provider, :uid], unique: true
  end
end
