class Friendship < ApplicationRecord
  extend Enumerize
  enumerize :state, in: [
    :apply,   #申请
    :agree,   #同意
    :ignore  #忽略
    ], default: :apply, predicates: {prefix: true}, scope: true
    belongs_to :user, optional: true
end
