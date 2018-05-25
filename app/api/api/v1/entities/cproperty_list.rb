# frozen_string_literal: true

module API
  module V1
    module Entities
      class CpropertyList < Grape::Entity
        expose :id, :keyname, :keytype
      end
    end
  end
end
