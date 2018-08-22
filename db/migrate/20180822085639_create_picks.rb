class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|

      t.timestamps
    end
  end
end
