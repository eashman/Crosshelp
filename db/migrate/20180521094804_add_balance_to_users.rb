# frozen_string_literal: true

class AddBalanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :balance, :decimal, precision: 6, scale: 2
  end
end
