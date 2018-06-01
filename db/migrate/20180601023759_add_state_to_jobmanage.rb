class AddStateToJobmanage < ActiveRecord::Migration[5.2]
  def change
    add_column :jobmanages, :state, :string, default: 'normal' #招聘权限
  end
end
