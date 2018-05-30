# frozen_string_literal: true
# == Schema Information
#
# Table name: enters
#
#  id             :bigint(8)        not null, primary key
#  activity_id    :integer
#  content        :json
#  name           :string
#  phone          :string
#  job            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  activityfee_id :integer
#

class Enter < ApplicationRecord
  belongs_to :activity, optional: true
  belongs_to :cproperty, optional: true
  has_one :ticket
end
