# frozen_string_literal: true

class CreateActivityfees < ActiveRecord::Migration[5.2]
  def change
    create_table :activityfees do |t|
      t.integer :activity_id
      t.string :name
      t.decimal :money, precision: 6, scale: 2
      t.integer :quota
      t.timestamps
    end
  end
end
