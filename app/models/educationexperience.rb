# == Schema Information
#
# Table name: educationexperiences
#
#  id           :bigint(8)        not null, primary key
#  applicant_id :integer
#  school       :string
#  major        :string
#  education    :string
#  begin_date   :date
#  end_date     :date
#  experience   :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Educationexperience < ApplicationRecord
  belongs_to :applicant, optional: true
end
