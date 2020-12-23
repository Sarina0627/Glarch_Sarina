class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :body
      t.date :date
      t.boolean :privacy
      t.integer :user_id
      t.integer :type_category_id
      t.integer  :area_category_id
      t.timestamps null:false
    end
  end
end
