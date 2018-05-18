# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Circles
        extend ActiveSupport::Concern
        included do
          desc '标签 [GET /circles]'
          get '/circles'  do
            user = current_user
            circles = user.circles
            wrap_meta(
              circles: Entities::CircleList.represent(circles).as_json
            )
          end

          desc '创建标签 [POST /circles/new]'
          params do
            requires :name, type: String, desc: '名称'
          end
          post '/circles/new' do
            user = current_user
            create_body = declared params
            circle = user.circles.create!(create_body.to_h)
            wrap_meta(ID: circle.id)
          end
          desc '加入标签 [ PATCH /circles/add]'
          params do
            requires :id, type: String, desc: 'ID'
            requires :friend_ids, type: Array[Integer], default: [], desc: '好友ID数组'
          end
          patch '/circles/add' do
            user = current_user
            create_body = declared params
            circle = user.circles.find(params.id)
            friend_ids  = circle.friend_ids
            friend_ids = friend_ids.concat params.friend_ids
            friend_ids.uniq!
            circle.update!(friend_ids: friend_ids)
            wrap_meta(friend_ids: friend_ids)
          end
        end
      end
    end
  end
end
