class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.integer :user_id
      t.string :name #姓名
      t.string :sex #性别
      t.string :head #头像
      t.date :begin_work_date #参加工作时间
      t.date :birthday #出生年月
      t.string :phone #手机号码
      t.string :job_status #求职状态
      t.text :advantage # 我的优势
      t.timestamps
    end
  end
end
