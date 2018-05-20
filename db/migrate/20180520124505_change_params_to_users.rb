class ChangeParamsToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :viper, :boolean
    remove_column :users, :corporater, :boolean
    remove_column :users, :authentication, :boolean
    add_column :users, :viper, :string, default: 'normal'
    add_column :users, :corporater, :string, default: 'normal'
    add_column :users, :authentication, :string, default: 'normal'
    add_column :users, :holdoffice, :string #担任职位
    add_column :users, :remark, :string #备注
  end
end
