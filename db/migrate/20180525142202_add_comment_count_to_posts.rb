class AddCommentCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comments_count, :integer, default: 0, index: true
  end
end
