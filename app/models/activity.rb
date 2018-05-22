# == Schema Information
#
# Table name: activities
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  poster     :string
#  title      :string
#  begin_time :datetime
#  end_time   :datetime
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Activity < ApplicationRecord
  belongs_to :user
  has_many :activityfees
end
