# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name # 公司名称
      t.text :summary # 公司简介
      t.string :logo # 公司logo
      t.string :address # 公司地址
      t.string :industry # 公司行业
      t.string :website  # 公司网址
      t.string :mailbox  # 公司邮箱
      t.timestamps
    end
  end
end
