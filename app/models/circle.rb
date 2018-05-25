# frozen_string_literal: true

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
#  friend_ids :integer          default([]), is an Array
#

class Circle < ApplicationRecord
  belongs_to :user, optional: true
end
