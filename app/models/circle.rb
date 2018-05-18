# == Schema Information
#
# Table name: circles
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Circle < ApplicationRecord
  belongs_to :user, optional: true
end
