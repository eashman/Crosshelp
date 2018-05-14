class CreateJoinTableUserLabel < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :labels do |t|
       t.index [:user_id, :label_id]
       t.index [:label_id, :user_id]
    end
  end
end
