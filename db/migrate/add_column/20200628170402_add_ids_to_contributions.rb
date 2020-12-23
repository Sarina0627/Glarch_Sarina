class AddIdsToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :areacategory_id, :integer
    add_column :contributions, :typecategory_id, :integer
  end
end
