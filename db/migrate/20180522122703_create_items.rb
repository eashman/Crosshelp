class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :parent_id, default: 0
      t.string :name
      t.integer :level, default: 0
      t.integer :sort, default: 0
      t.timestamps
    end
  end
end
