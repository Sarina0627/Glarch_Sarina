class CreateFavreactions < ActiveRecord::Migration[5.2]
  def change
    create_table :favreactions do |t|
      t.string "favmemo"
      t.integer "contribution_id"
      t.timestamps null:false
    end
  end
end
