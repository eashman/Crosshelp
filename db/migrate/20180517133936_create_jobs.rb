# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.integer :parent_id, default: 0
      t.string :name
      t.integer :level, default: 0
      t.integer :sort, default: 0
      t.timestamps
    end
    add_index :jobs, :parent_id
  end
end
