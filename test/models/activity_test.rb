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

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
