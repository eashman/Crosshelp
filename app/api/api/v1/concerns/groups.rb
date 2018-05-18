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
            wrap_meta(group: group)
          end

          desc '加入圈子[ POST /groups/add]'
          params do
            requires :group_id, type: String, desc: '圈子ID'
          end
          post '/groups/add' do
            user = current_user
            user_group = UserGroup.create!(user_id: user.id,group_id: params.group_id)
            wrap_meta(msg: '加入成功')
          end
        end
      end
    end
  end
end
