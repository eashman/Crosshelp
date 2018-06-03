# == Schema Information
#
# Table name: applicants
#
#  id              :bigint(8)        not null, primary key
#  user_id         :integer
#  name            :string
#  sex             :string
#  head            :string
#  begin_work_date :date
#  birthday        :date
#  phone           :string
#  job_status      :string
#  advantage       :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachment      :string
#

require 'test_helper'

class ApplicantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
