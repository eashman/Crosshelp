# -*- coding: utf-8 -*-
module API
  module V1
    module Entities
      class ActivityList < Grape::Entity
        expose :id, :poster, :title, :address,:address,:end_time
      end
    end
  end
end
