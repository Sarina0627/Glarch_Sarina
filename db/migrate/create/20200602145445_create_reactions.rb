class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.string :comment
      t.integer :favorite
      t.integer :contribution_id
      t.integer :user_id
      t.timestamps null:false
    end
  end
end
