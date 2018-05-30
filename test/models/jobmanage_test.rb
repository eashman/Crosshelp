# == Schema Information
#
# Table name: jobmanages
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer
#  company_name :string
#  position     :string
#  address      :string
#  kind         :string
#  ability      :string
#  salary       :string
#  experience   :string
#  education    :string
#  workcontent  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class JobmanageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
