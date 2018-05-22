# -*- coding: utf-8 -*-
module API
  module V1
    module Entities
      class CpropertyList < Grape::Entity
        expose :id, :keyname, :keytype
      end
    end
  end
end
