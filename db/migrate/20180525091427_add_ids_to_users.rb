class AddIdsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :collection_ids, :integer, default: [], array: true
    add_column :users, :follow_ids, :integer, default: [], array: true
  end
end
