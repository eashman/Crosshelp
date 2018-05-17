# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Friends
        extend ActiveSupport::Concern
        included do
          desc '好友列表 [GET /friends]'
          get '/friends'  do
            user = current_user
            friends = user.friends
            wrap_meta(
              friends: friends
            )
          end

          desc '申请好友 [POST /friends/apply]'
          params do
            requires :friend_id, type: String, desc: '好友ID'
            requires :name, type: String, desc: '好友名字'
          end
          post '/friends/apply' do
            user = current_user
            create_body = declared params
            friend = user.friends.create!(create_body.to_h)
            wrap_meta(friend: friend)
          end


          desc '同意或忽略好友 [PATCH /friends/agree]'
          params do
            requires :id, type: String, desc: '好友ID'
            requires :state, type: String, values: %w(apply agree ignore), desc: '状态'
          end
          patch '/friends/agree' do
            user = current_user
            friend = Friend.find(params.id)
            friend.update!(state: params.state)
            wrap_meta(ID: friend.id)
          end

          desc '同校好友列表[GET /friends/school ]'
          params do
            requires :school, type: String, desc: '学校'
          end
          get '/friends/school' do
            user = current_user
            friends = User.where(school: user.school)
            wrap_meta(friends: Entities::FriendList.represent(friends).as_json)
          end
          
          desc '生日好友列表[GET /friends/birthday ]'
          params do
            requires :birthday, type: DateTime, desc: '生日'
          end
          get '/friends/birthday' do
            user = current_user
            friends = User.where(birthday: user.birthday)
            wrap_meta(friends: Entities::FriendList.represent(friends).as_json)
          end
        end
      end
    end
  end
end
