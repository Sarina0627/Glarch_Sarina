class CreateAreacategories < ActiveRecord::Migration[5.2]
  def change
    create_table :areacategories do |t|
    t.string :area_name
    t.timestamps null:false
   end
  end
end
