# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Posts
        extend ActiveSupport::Concern
        included do
          desc '获取提问列表 [GET /posts]'
          get '/posts' do
            user = current_user
            posts = user.posts
            wrap_meta(
              posts: Entities::PostList.represent(posts).as_json
            )
          end

          desc '提问 [POST /posts/new]'
          params do
            requires :title, type: String, desc: '主题'
            requires :content, type: String, desc: '内容'
          end
          post '/posts/new' do
            user = current_user
            create_body = declared params
            post = user.posts.create!(create_body.to_h)
            wrap_meta(post: post)
          end
        end
      end
    end
  end
end
