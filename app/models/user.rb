# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  phone            :string(11)
#  open_id          :string
#  token            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  viper            :boolean          default(FALSE)
#  corporater       :boolean          default(FALSE)
#  job              :boolean          default(FALSE)
#  profession       :string
#  vipercount       :integer          default(2)
#  badge            :string
#  company          :string
#  authentication   :boolean          default(FALSE)
#  sex              :string
#  birthday         :date
#  province         :string
#  city             :string
#  school           :string
#  industry         :string
#  summary          :text
#  business_licence :string
#  star_posts_count :integer          default(0)
#  followers_count  :integer          default(0)
#  following_count  :integer          default(0)
#

class User < ApplicationRecord
  has_secure_token
  has_and_belongs_to_many :labels
  has_many :activities
  action_store :like, :post, counter_cache: true
  action_store :star, :post, counter_cache: true, user_counter_cache: true
  action_store :follow, :post
  action_store :like, :comment, counter_cache: true
  action_store :follow, :user, counter_cache: 'followers_count', user_counter_cache: 'following_count'
end
