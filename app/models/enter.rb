# == Schema Information
#
# Table name: enters
#
#  id            :bigint(8)        not null, primary key
#  activity_id   :integer
#  enterkey_id   :integer
#  entervalue_id :integer
#  over_time     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Enter < ApplicationRecord
  belongs_to :activity
  belongs_to :cproperty
end
