# == Schema Information
#
# Table name: jobs
#
#  id         :bigint(8)        not null, primary key
#  parent_id  :integer
#  name       :string
#  level      :integer
#  sort       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Job < ApplicationRecord
  belongs_to :parent, class_name: 'Job', foreign_key: 'parent_id'
  has_many :children, class_name: 'Job', foreign_key: 'parent_id'
end
