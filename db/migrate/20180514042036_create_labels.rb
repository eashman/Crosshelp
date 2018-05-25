# frozen_string_literal: true

class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :tag
      t.integer :sort
      t.timestamps
    end
  end
end
