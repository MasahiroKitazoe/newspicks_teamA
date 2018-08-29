class AddSourceToPicks < ActiveRecord::Migration[5.1]
  def change
    add_column :picks, :source, :string, null:false
  end
end
