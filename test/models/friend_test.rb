# frozen_string_literal: true

# == Schema Information
#
# Table name: friends
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :integer
#

require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
