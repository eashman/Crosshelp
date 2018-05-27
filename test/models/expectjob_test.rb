# == Schema Information
#
# Table name: expectjobs
#
#  id           :bigint(8)        not null, primary key
#  applicant_id :integer
#  industry     :string
#  job          :string
#  city         :string
#  salary       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ExpectjobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
