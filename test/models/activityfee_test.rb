# frozen_string_literal: true

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

require 'test_helper'

class ActivityfeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
