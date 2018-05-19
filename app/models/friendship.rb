# == Schema Information
#
# Table name: friendships
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  name       :string
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  extend Enumerize
  enumerize :state, in: [
    :apply,   #申请
    :agree,   #同意
    :ignore  #忽略
    ], default: :apply, predicates: {prefix: true}, scope: true
    belongs_to :user, optional: true

    scope :friend_ids, -> (id) {
      where('user_id = ? or friend_id = ? and state = ? ', id,id,'agree').select('user_id,friend_id')
    }
end
