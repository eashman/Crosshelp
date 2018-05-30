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

class Jobmanage < ApplicationRecord
  belongs_to :user, optional: true
  has_and_belongs_to_many :applicants
end
