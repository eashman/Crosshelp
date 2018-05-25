# frozen_string_literal: true

# == Schema Information
#
# Table name: labels
#
#  id         :bigint(8)        not null, primary key
#  tag        :string
#  sort       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
