# == Schema Information
#
# Table name: activityfees
#
#  id          :bigint(8)        not null, primary key
#  activity_id :integer
#  name        :string
#  money       :decimal(6, 2)
#  quota       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Activityfee < ApplicationRecord
  belongs_to :activity
end
