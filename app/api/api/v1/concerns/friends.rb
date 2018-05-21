# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Friends
        extend ActiveSupport::Concern
        included do
          desc '好友列表 [GET /friends]'
          params do
            optional :id, type: String, desc: '用户ID'
          end
          get '/friends'  do
            user = current_user
            friend_ids = Friendship.friend_ids(user.id).to_a
            user_ids = friend_ids.pluck(:user_id)
            friend_ids = friend_ids.pluck(:friend_id)
            ids = user_ids.concat friend_ids
            ids.uniq!
            friends = User.find(ids)
            wrap_meta(
              friends: Entities::UserList.represent(friends).as_json
            )
          end
          desc 'search好友 [GET /friends/search]'
          params do
            optional :q, type: String,desc: '手机号码或者名字'
          end
          get '/friends/search' do
            users = User.search(params.q, fields: [:name,:phone], match: :text_middle).results
            wrap_meta(
              users: Entities::UserList.represent(users).as_json
            )
          end

          desc '申请好友列表 [GET /friends/apply/list]'
          get '/friends/apply/list' do
            user = current_user
            friends = Friendship.find_by(user_id: user.id)
            wrap_meta(
              friends: Entities::FriendshipList.represent(friends).as_json
            )
          end

          desc '圈子好友 [GET /friends/circle]'
          params do
            requires :friend_id, type: String, desc: '圈子ID'
          end
          get '/friends/circle' do
            user = current_user
            circle = user.circles.find_by(id: params.friend_id)
            circle_friends = user.find(circle.friend_ids)  if circle
            wrap_meta(
              friends: Entities::UserList.represent(circle_friends).as_json
            )
          end

          desc '申请好友 [POST /friends/apply]'
          params do
            requires :friend_id, type: String, desc: '好友ID'
            requires :name, type: String, desc: '名字'
          end
          post '/friends/apply' do
            user = current_user
            create_body = declared params
            body_h = create_body.to_h
            body_h.merge!(user_id: user.id)
            friendship = Friendship.create!(body_h)
            wrap_meta(friendship: friendship)
          end


          desc '同意或忽略好友 [PATCH /friends/agree]'
          params do
            requires :id, type: String, desc: 'ID'
            requires :state, type: String, values: %w(apply agree ignore), desc: '状态'
          end
          patch '/friends/agree' do
            user = current_user
            friendship = Friendship.find_by(id: params.id)
            friendship.update!(state: params.state)
            wrap_meta(friendship: friendship)
          end

          desc '同校好友列表[GET /friends/school ]'
          params do
            optional :school, type: String, desc: '学校'
          end
          get '/friends/school' do
            user = current_user
            friends = User.where(school: user.school).to_a
            friends = friends.delete_if {|friend| friend.id == user.id }
            wrap_meta(friends: Entities::FriendList.represent(friends).as_json)
          end

          desc '生日好友列表[GET /friends/birthday ]'
          params do
            optional :birthday, type: DateTime, desc: '生日'
          end
          get '/friends/birthday' do
            user = current_user
            friends = User.where(birthday: user.birthday).to_a
            friends = friends.delete_if {|friend| friend.id == user.id }
            wrap_meta(friends: Entities::FriendList.represent(friends).as_json)
          end

          desc '同乡好友列表[GET /friends/city]'
          params do
            optional :city, type: String, desc: '市'
          end
          get '/friends/city' do
            user = current_user
            friends = User.where(city: user.city).to_a
            friends = friends.delete_if {|friend| friend.id == user.id }
            wrap_meta(friends: Entities::FriendList.represent(friends).as_json)
          end
        end
      end
    end
  end
end
