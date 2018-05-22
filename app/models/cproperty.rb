# == Schema Information
#
# Table name: cproperties
#
#  id         :bigint(8)        not null, primary key
#  keyname    :string
#  keytype    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cproperty < ApplicationRecord
  has_many :enters
end
