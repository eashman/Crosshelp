# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :author
      t.string :image
      t.string :order_index
      t.boolean :hidden, default: false
      t.timestamps
    end
  end
end
