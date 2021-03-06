# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id             :bigint(8)        not null, primary key
#  title          :string
#  content        :text
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  likes_count    :integer          default(0)
#  stars_count    :integer          default(0)
#  comments_count :integer          default(0)
#

class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments
  searchkick callbacks: :async, text_middle: %i[content]
end
