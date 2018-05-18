class AddFriendIdsToCircles < ActiveRecord::Migration[5.2]
  def change
    add_column :circles, :friend_ids, :integer,default: [], array: true
  end
end
