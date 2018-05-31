class AddCompanyIdToJobmanage < ActiveRecord::Migration[5.2]
  def change
    add_column :jobmanages, :company_id, :integer, index: true
  end
end
