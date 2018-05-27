# == Schema Information
#
# Table name: workexperiences
#
#  id           :bigint(8)        not null, primary key
#  applicant_id :integer
#  position     :string
#  department   :string
#  company_name :string
#  begin_date   :date
#  end_date     :date
#  job_content  :text
#  performance  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class WorkexperienceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
