# frozen_string_literal: true
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
#  job              :boolean          default(FALSE)
#  profession       :string
#  vipercount       :integer          default(2)
#  badge            :string
#  company          :string
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
#  viper            :string           default("normal")
#  corporater       :string           default("normal")
#  authentication   :string           default("normal")
#  holdoffice       :string
#  remark           :string
#  imtoken          :string
#  balance          :decimal(6, 2)
#  activityids      :integer          default([]), is an Array
#  collection_ids   :integer          default([]), is an Array
#  follow_ids       :integer          default([]), is an Array
#  recruit          :string           default("normal")
#

class User < ApplicationRecord
  extend Enumerize
  searchkick callbacks: :async, text_middle: %i[name phone]
  has_secure_token
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :groups
  has_many :activities
  has_many :posts
  has_many :comments
  has_one :applicant
  has_many :friendships
  has_many :orders
  has_many :jobmanages
  belongs_to :company, optional: true
  has_and_belongs_to_many :friends, class_name: 'User', join_table: 'friendships', association_foreign_key: 'friend_id', foreign_key: 'user_id'
  has_many :circles
  enumerize :viper, in: [
    :normal, # 未申请
    :apply,  # 申请
    :agree,  # 同意
    :ignore  # 忽略
  ], default: :normal, predicates: { prefix: true }, scope: true
  enumerize :corporater, in: [
    :normal, # 未申请
    :apply,  # 申请
    :agree,  # 同意
    :ignore  # 忽略
  ], default: :normal, predicates: { prefix: true }, scope: true
  enumerize :authentication, in: [
    :normal, # 未申请
    :apply,  # 申请
    :success, # 同意
    :cancel # 已取消
  ], default: :normal, predicates: { prefix: true }, scope: true
  enumerize :recruit, in: [
    :normal, # 普通
    :admin,  # 招聘
    :superadmin, # 超级招聘
  ], default: :normal, predicates: { prefix: true }, scope: true
  after_create do
    self.create_applicant #创建个人简历表
  end
  action_store :like, :post, counter_cache: true
  action_store :star, :post, counter_cache: true, user_counter_cache: true
  action_store :follow, :post
  action_store :like, :comment, counter_cache: true
  action_store :follow, :user, counter_cache: 'followers_count', user_counter_cache: 'following_count'
end
