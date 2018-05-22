# == Schema Information
#
# Table name: activities
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer
#  poster       :string
#  title        :string
#  begin_time   :datetime
#  end_time     :datetime
#  address      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  body         :string
#  deadline     :datetime
#  cpropertyids :integer          default([]), is an Array
#  itemids      :integer          default([]), is an Array
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
