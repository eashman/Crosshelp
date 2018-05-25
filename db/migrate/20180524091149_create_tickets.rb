# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :enter_id
      t.integer :order_id
      t.integer :activity_id
      t.string :state, default: 'created'
      t.string :code
      t.string :Qrcode
      t.timestamps
    end
  end
end
