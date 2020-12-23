class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    t.string :name
    t.string :username
    t.string :password
    t.string :icon_img
    t.string :area
    t.string :introduction
    t.timestamps null:false
   end
  end
end
