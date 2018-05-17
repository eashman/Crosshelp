# -*- coding: utf-8 -*-
module API
  module V1
    module Entities
      class FriendList < Grape::Entity
        expose :id, :name
      end
    end
  end
end
