class AddPublicToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :public, :boolean
  end
end
