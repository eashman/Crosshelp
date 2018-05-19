# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Cloud
        extend ActiveSupport::Concern
        included do
          desc 'getToken获取Token [POST /rongcloud/user/getToken]'
          params do
            requires :id, type: String, desc: 'ID'
            optional :name, type: String, desc: '名字'
            optional :photo, type: String, desc: '头像'
          end
          post '/rongcloud/user/getToken' do
            result = rcservice.get_token(params.id,params.name,params.photo)
            wrap_meta(result: result)
          end

          desc '检查用户在线状态方法 [POST /rongcloud/user/checkOnline]'
          params do
            requires :id, type: String, desc: 'ID'
          end
          post '/rongcloud/user/checkOnline' do
            result = rcservice.check_online(params.id)
            wrap_meta(result: result)
          end
        end
      end
    end
  end
end
