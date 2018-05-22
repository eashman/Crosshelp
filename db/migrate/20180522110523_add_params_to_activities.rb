class AddParamsToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :body, :string
    add_column :activities, :deadline, :datetime
  end
end
