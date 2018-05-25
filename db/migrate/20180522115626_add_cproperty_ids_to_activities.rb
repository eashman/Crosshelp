# frozen_string_literal: true

class AddCpropertyIdsToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :cpropertyids, :integer, default: [], array: true
    add_column :activities, :itemids, :integer, default: [], array: true
  end
end
