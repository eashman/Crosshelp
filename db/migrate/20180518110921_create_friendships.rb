class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    drop_table(:friends)
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :name
      t.string :state
      t.timestamps
    end
  end
end
