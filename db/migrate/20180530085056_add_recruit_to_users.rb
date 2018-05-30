class AddRecruitToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :recruit, :string, default: 'normal' #招聘权限
  end
end
