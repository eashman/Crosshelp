# frozen_string_literal: true
# == Schema Information
#
# Table name: tickets
#
#  id          :bigint(8)        not null, primary key
#  enter_id    :integer
#  order_id    :integer
#  activity_id :integer
#  state       :string           default("created")
#  code        :string
#  Qrcode      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  remark      :string
#

require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
