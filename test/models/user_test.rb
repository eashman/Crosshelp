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
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
