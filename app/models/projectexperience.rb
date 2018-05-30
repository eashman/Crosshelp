# == Schema Information
#
# Table name: projectexperiences
#
#  id              :bigint(8)        not null, primary key
#  applicant_id    :integer
#  project_name    :string
#  project_connect :string
#  employment      :string
#  role            :string
#  begin_date      :date
#  end_date        :date
#  project_content :text
#  performance     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Projectexperience < ApplicationRecord
  belongs_to :applicant, optional: true
end
