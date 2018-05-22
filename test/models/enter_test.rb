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

require 'test_helper'

class EnterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
