# frozen_string_literal: true

class CreateAdministrators < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.datetime :remember_token_expires_at

      t.timestamps
    end
  end
end
