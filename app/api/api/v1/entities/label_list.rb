# -*- coding: utf-8 -*-
module API
  module V1
    module Entities
      class LabelList < Grape::Entity
        expose :id, :tag, :sort
      end
    end
  end
end
