class CreateWorkexperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :workexperiences do |t|
      t.integer :applicant_id
      t.string :position #职位
      t.string :department #部门
      t.string :company_name #公司名称
      t.date :begin_date #时间段开始时间
      t.date :end_date  #时间段结束时间
      t.text :job_content #工作内容
      t.text :performance #工作业绩
      t.timestamps
    end
  end
end
