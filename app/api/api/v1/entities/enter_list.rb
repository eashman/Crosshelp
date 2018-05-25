# frozen_string_literal: true

module API
  module V1
    module Entities
      class EnterList < Grape::Entity
        expose :id, :name, :phone
      end
    end
  end
end
