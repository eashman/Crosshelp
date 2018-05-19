# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Groups
        extend ActiveSupport::Concern
        included do
          desc '圈子 [GET /groups]'
          get '/groups' do
            user = current_user
            groups = user.groups
            wrap_meta(
              groups: Entities::GroupList.represent(groups).as_json
            )
          end
          desc '圈子用户 [GET /groups/users]'
          params do
            requires :group_id, type: String, desc: 'ID'
          end
          get '/groups/users' do
            group = Group.find_by(id: params.group_id)
            users = group.users
            wrap_meta(
              users: Entities::UserList.represent(users).as_json
            )
          end

          desc '创建圈子[ POST /groups/new]'
          params do
            requires :name, type: String, desc: '名称'
            requires :address, type: String, desc: '标示地区'
          end
          post '/groups/new' do
            user = current_user
            create_body = declared params
            group = user.groups.create!(create_body.to_h)
            #创建群组方法#
            result = rcservice.create_group(user.id,group.id,group.name)
            wrap_meta(result: result)
          end

          desc '加入圈子[ POST /groups/add]'
          params do
            optional :userId, type: String, desc: '用户Id'
            requires :groupId, type: String, desc: '圈子Id'
            requires :groupName, type: String, desc: '圈子名称'
          end
          post '/groups/add' do
            user = current_user
            group = Group.find_by(id: params.groupId)
            #user = User.find_by(id: params.userId)
            group.users << user
            #加入群组方法#
            result = rcservice.join_group(user.id,params.groupId,params.groupName)
            wrap_meta(result: result)
          end
        end
      end
    end
  end
end
