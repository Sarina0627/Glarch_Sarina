class RemoveFavmemoFromReactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :reactions, :favmemo, :string
  end
end
