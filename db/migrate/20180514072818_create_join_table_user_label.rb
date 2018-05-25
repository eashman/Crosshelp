# frozen_string_literal: true

class CreateJoinTableUserLabel < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :labels do |t|
      t.index %i[user_id label_id]
      t.index %i[label_id user_id]
    end
  end
end
