class AddAreaToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :area, :string
  end
end
