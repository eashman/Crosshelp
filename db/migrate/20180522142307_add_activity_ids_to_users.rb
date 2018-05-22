class AddActivityIdsToUsers < ActiveRecord::Migration[5.2]
  def change
      add_column :users, :activityids, :integer,default: [], array: true
  end
end
