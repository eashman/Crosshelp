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

class Expectjob < ApplicationRecord
  belongs_to :applicant, optional: true
end
