# == Schema Information
#
# Table name: companies
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
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
  belongs_to :user
end
