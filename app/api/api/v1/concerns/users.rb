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
        end
      end
    end
  end
end
