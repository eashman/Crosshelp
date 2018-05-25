# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :name
      t.datetime :paytime
      t.string :state, default: 'created'
      t.decimal :sum, precision: 6, scale: 2
      t.decimal :factsum, precision: 6, scale: 2
      t.timestamps
    end
  end
end
