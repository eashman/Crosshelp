# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Posts
        extend ActiveSupport::Concern
        included do
          desc '获取提问列表 [GET /posts]'
          get '/posts'  do
            @current_user = current_user
            posts = @current_user.posts
            wrap_meta(
              posts: Entities::PostList.represent(posts).as_json
            )
          end

          desc '提问 [POST /posts/new]'
          params do
            requires :title, type: String, desc: '主题'
            requires :content,  type: String, desc: '内容'
          end
          post '/posts/new' do
            @current_user = current_user
            create_body = declared params
            post = @current_user.posts.create!(create_body.to_h)
            wrap_meta(post: post)
          end
        end
      end
    end
  end
end
