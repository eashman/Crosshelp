class CreateExpectjobs < ActiveRecord::Migration[5.2]
  def change
    create_table :expectjobs do |t|
      t.integer :applicant_id
      t.string :industry #期望行业
      t.string :job #期望职位
      t.string :city #工作城市
      t.string :salary #期望薪资
      t.timestamps
    end
  end
end
