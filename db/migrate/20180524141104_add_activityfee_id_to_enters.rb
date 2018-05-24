class AddActivityfeeIdToEnters < ActiveRecord::Migration[5.2]
  def change
    add_column :enters, :activityfee_id, :integer , index: true
  end
end
