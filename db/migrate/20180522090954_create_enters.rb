# frozen_string_literal: true

class CreateEnters < ActiveRecord::Migration[5.2]
  def change
    create_table :enters do |t|
      t.integer :activity_id
      t.json :content, default: {}
      t.string :name
      t.string :phone
      t.string :job
      t.timestamps
    end
  end
end
