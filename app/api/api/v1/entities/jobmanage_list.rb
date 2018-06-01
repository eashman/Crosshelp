# frozen_string_literal: true

module API
  module V1
    module Entities
      class JobmanageList < Grape::Entity
        expose :id, :position, :salary
      end
    end
  end
end
