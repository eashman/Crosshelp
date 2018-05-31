# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  summary    :text
#  logo       :string
#  address    :string
#  industry   :string
#  website    :string
#  mailbox    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord
  has_many :users
  has_many :jobmanages
end
