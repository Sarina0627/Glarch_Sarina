class AddFavmemoToReactions < ActiveRecord::Migration[5.2]
  def change
    add_column :reactions, :favmemo, :string
  end
end
