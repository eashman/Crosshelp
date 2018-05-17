class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.integer :parent_id
      t.string :name
      t.integer :level
      t.integer :sort
      t.timestamps
    end
  end
end
