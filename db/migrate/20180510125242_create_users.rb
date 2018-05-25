# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone, limit: 11
      t.string :open_id
      t.string :token
      t.timestamps
    end
    add_index :users, :phone
    add_index :users, :open_id
    add_index :users, :token
  end
end
