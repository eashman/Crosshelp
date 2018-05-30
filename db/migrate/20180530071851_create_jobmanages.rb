class CreateJobmanages < ActiveRecord::Migration[5.2]
  def change
    create_table :jobmanages do |t|
      t.integer :user_id
      t.string :company_name # 公司信息
      t.string :position #职位类型
      t.string :address #工作地点
      t.string :kind #工作性质
      t.string :ability #工作要求
      t.string :salary #薪资范围
      t.string :experience #经验要求
      t.string :education #最低学历
      t.string :workcontent #职位描述
      t.timestamps
    end
  end
end
