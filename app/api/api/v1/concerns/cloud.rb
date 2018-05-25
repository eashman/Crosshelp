# frozen_string_literal: true

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
            user = User.find_by(id: params.id)
            result = rcservice.get_token(params.id, params.name, params.photo)
            p result.fetch('token')
            if user
              user.update!(imtoken: result.fetch('token'))
              wrap_meta(result: result)
            else
              wrap_meta('ID不存在该用户')
            end
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
