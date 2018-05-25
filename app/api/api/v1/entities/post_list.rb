# frozen_string_literal: true

module API
  module V1
    module Entities
      class PostList < Grape::Entity
        expose :id, :content
      end
    end
  end
end
