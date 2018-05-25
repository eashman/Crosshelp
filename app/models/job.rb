# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id         :bigint(8)        not null, primary key
#  parent_id  :integer          default(0)
#  name       :string
#  level      :integer          default(0)
#  sort       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Job < ApplicationRecord
  belongs_to :parent, class_name: 'Job', foreign_key: 'parent_id', optional: true
  has_many :children, class_name: 'Job', foreign_key: 'parent_id'
end
