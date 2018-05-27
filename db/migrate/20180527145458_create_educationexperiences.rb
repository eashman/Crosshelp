class CreateEducationexperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :educationexperiences do |t|
      t.integer :applicant_id
      t.string :school #学校
      t.string :major #专业
      t.string :education #学历
      t.date :begin_date #时间段开始时间
      t.date :end_date  #时间段结束时间
      t.text :experience #在校经历
      t.timestamps
    end
  end
end
