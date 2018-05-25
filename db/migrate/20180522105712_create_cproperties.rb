# frozen_string_literal: true

class CreateCproperties < ActiveRecord::Migration[5.2]
  def change
    create_table :cproperties do |t|
      t.string :keyname
      t.string :keytype
      t.timestamps
    end
  end
end
