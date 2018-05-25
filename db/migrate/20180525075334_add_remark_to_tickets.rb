# frozen_string_literal: true

class AddRemarkToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :remark, :string # 退票理由
  end
end
