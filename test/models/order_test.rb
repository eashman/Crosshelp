# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  paytime    :datetime
#  state      :string           default("created")
#  sum        :decimal(6, 2)
#  factsum    :decimal(6, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
