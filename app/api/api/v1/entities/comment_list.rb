# frozen_string_literal: true

module API
  module V1
    module Entities
      class CommentList < Grape::Entity
        expose :id, :body
        expose :user do |c,_|
          if c.user
            { name: c.user.name, photo: c.user.photo }
          else
            {}
          end
        end
      end
    end
  end
end
