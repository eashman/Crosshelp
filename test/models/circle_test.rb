# == Schema Information
#
# Table name: circles
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_ids :integer          default([]), is an Array
#

require 'test_helper'

class CircleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
