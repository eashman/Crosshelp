# frozen_string_literal: true
# == Schema Information
#
# Table name: comments
#
#  id          :bigint(8)        not null, primary key
#  body        :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  likes_count :integer          default(0)
#  post_id     :integer
#

class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true, counter_cache: true
end
