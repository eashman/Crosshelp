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
#  photo            :string
#  card             :string
#  company_id       :integer
#

class User < ApplicationRecord
  has_secure_token
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :groups
  has_many :activities
  has_many :posts
  has_many :comments
  has_many :friendships
  belongs_to :company, optional: true
  has_and_belongs_to_many :friends,class_name: 'User',join_table: 'friendships',association_foreign_key: 'friend_id', foreign_key: 'user_id'
  has_many :circles
  action_store :like, :post, counter_cache: true
  action_store :star, :post, counter_cache: true, user_counter_cache: true
  action_store :follow, :post
  action_store :like, :comment, counter_cache: true
  action_store :follow, :user, counter_cache: 'followers_count', user_counter_cache: 'following_count'
end
