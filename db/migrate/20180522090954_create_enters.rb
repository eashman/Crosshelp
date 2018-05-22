class CreateEnters < ActiveRecord::Migration[5.2]
  def change
    create_table :enters do |t|
      t.integer :activity_id
      t.string :content
      t.integer :cproperty_id
      t.timestamps
    end
  end
end
