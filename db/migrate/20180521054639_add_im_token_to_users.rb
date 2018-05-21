class AddImTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :imtoken, :string #IM用户token
  end
end
