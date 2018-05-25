# frozen_string_literal: true

class AddPersonalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sex, :string
    add_column :users, :birthday, :date
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :school, :string
    add_column :users, :industry, :string
    add_column :users, :summary, :text
  end
end
