# frozen_string_literal: true

module API
  module V1
    module Entities
      class CircleList < Grape::Entity
        expose :id, :name, :friend_ids
        expose :friend_ids do |ids, _|
          User.find(ids).map do |_f|
            { id: _f.id, name: _f.name }
          end
        end
      end
    end
  end
end
