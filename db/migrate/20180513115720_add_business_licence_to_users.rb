# frozen_string_literal: true

class AddBusinessLicenceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :business_licence, :string # 营业执照
  end
end
