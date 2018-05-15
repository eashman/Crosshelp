class AddToUserPostComment < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :star_posts_count, :integer, default: 0
    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :following_count, :integer, default: 0
    add_column :posts, :likes_count, :integer, default: 0
    add_column :posts, :stars_count, :integer, default: 0
    add_column :comments, :likes_count, :integer, default: 0
  end
end
