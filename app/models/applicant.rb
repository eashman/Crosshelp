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
#

class Applicant < ApplicationRecord
  has_and_belongs_to_many :jobmanages
  belongs_to :user, optional: true
  has_many :educationexperiences
  has_many :expectjobs
  has_many :projectexperiences
  has_many :workexperiences
end
