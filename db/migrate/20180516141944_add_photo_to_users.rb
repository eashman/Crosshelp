class AddPhotoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photo, :string #营业执照
  end
end
