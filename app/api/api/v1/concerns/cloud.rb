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
            requires :name, type: String, desc: '名字'
            requires :photo, type: String, desc: '头像'
          end
          post '/rongcloud/user/getToken' do
            result = rcservice.get_token(params.id,params.name,params.photo)
            wrap_meta(result: result)
          end
        end
      end
    end
  end
end
