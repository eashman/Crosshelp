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
end
