# == Schema Information
#
# Table name: labels
#
#  id         :bigint(8)        not null, primary key
#  tag        :string
#  sort       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Label < ApplicationRecord
  has_and_belongs_to_many :users
end
