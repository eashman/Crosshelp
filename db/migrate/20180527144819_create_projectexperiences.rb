class CreateProjectexperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :projectexperiences do |t|
      t.integer :applicant_id
      t.string :project_name #项目名称
      t.string :project_connect #项目衔接
      t.string :employment #人数
      t.string :role #担任角色
      t.date :begin_date #时间段开始时间
      t.date :end_date  #时间段结束时间
      t.text :project_content #项目内容
      t.text :performance #项目业绩
      t.timestamps
    end
  end
end
