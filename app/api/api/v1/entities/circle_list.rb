# -*- coding: utf-8 -*-
module API
  module V1
    module Entities
      class CircleList < Grape::Entity
        expose :id, :name, :friend_ids
      end
    end
  end
end
