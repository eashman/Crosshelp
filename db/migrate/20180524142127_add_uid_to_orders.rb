# frozen_string_literal: true

class AddUidToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :uid, :string
  end
end
