# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :poster # 主题海报
      t.string :title # 主题
      t.datetime :begin_time
      t.datetime :end_time
      t.string :address
      t.timestamps
    end
  end
end
