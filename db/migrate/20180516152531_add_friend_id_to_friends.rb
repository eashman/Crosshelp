# frozen_string_literal: true

class AddFriendIdToFriends < ActiveRecord::Migration[5.2]
  def change
    add_column :friends, :friend_id, :integer
  end
end
