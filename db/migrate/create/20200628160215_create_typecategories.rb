class CreateTypecategories < ActiveRecord::Migration[5.2]
  def change
    create_table :typecategories do |t|
    t.string :type_name
    t.timestamps null:false
   end
  end
end
