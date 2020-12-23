class CreateNewFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :newfavorites do |t|
      t.integer :favorite
      t.integer :contribution_id
      t.integer :user_id
      t.timestamps null:false
    end
  end
end
