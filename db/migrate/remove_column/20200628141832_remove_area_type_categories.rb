class RemoveAreaTypeCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :contributions, :typecategory_id, :integer
    remove_column :contributions, :type_category_id, :integer
    remove_column :contributions, :areacategory_id, :integer
    remove_column :contributions, :area_category_id, :integer
    remove_column :contributions, :privacy, :boolean
    remove_column :users, :address, :string
  end
end
