class AddParamsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :viper, :boolean, default: false # vip
    add_column :users, :corporater, :boolean, default: false #企业
    add_column :users, :job, :boolean, default: false #高管
    add_column :users, :profession, :string #职业
    add_column :users, :vipercount, :integer,default: 2 #3vip用户数
    add_column :users, :badge, :string #工牌
    add_column :users, :company, :string #公司名称
    add_column :users, :authentication, :boolean, default: false #认证
  end
end
