# -*- coding: utf-8 -*-
module API
  module V1
    module Entities
      class PostList < Grape::Entity
        expose :id,:title
      end
    end
  end
end
