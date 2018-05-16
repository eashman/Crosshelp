# == Schema Information
#
# Table name: friends
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friend < ApplicationRecord
  belongs_to :user
  extend Enumerize

  enumerize :state, in: {
    apply: 0,  #申请
    agree: 1,  #同意
    ignore: 99  #忽略
    }, default: :apply, predicates: {prefix: true}, scope: true
end
