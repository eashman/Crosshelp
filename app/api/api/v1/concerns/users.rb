# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Users
        extend ActiveSupport::Concern
        included do
          desc '登录 [POST /users/login]'
          params do
            requires :phone, type: String, desc: '手机号码'
            requires :open_id, type: String, desc: '微信标识'
          end
          post '/users/login' do
            create_body = declared params
            user = ::User.create!(create_body.to_h)
            wrap_meta(token: user.token)
          end

          desc '完善个人信息 [PUT /users/perfect]'
          params do
            requires :sex, type: String
            requires :birthday, type: String
            requires :province, type: String
            requires :city, type: String
            requires :school, type: String
            requires :industry, type: String
            requires :summary, type: String
          end
          put '/users/perfect' do
            current_user
            create_body = declared params
            current_user.update!(create_body.to_h)
            wrap_meta(token: @current_user.token)
          end

          desc '个人信息 [get /users/show]'
          get '/users/show' do
            current_user
            wrap_meta(
              user: current_user
            )
          end
        end
      end
    end
  end
end
