class AddCardToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :card, :string #名片
  end
end
