# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  paytime    :datetime
#  state      :string           default("created")
#  sum        :decimal(6, 2)
#  factsum    :decimal(6, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :user
  has_one :ticket
  extend Enumerize
  enumerize :state, in: [
    :created, # 生成订单
    :paid, # 已付款
    :processing, # 未付款
    :cancel      # 已取消
  ], default: :created, predicates: { prefix: true }, scope: true

  before_create do
    generateUid
  end
  def generateUid
    number = [*(0..9)].sample(15).join
    loop do
      if $redisOrder.sismember('number', number)
        number = [*(0..9)].sample(15).join
      else
        $redisOrder.sadd('number', number)
       end
    end
    self.uid = number
  end
end
