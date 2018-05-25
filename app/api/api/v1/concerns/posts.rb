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

          desc '提问的回答 [GET /posts/comments/list]'
          params do
            requires :postId, type: String, desc: '提问ID'
          end
          get '/posts/comments/list' do
            user = current_user
            post = Post.find_by(id: params.postId)
            comments = post.comments if post
            wrap_meta(comments: Entities::CommentList.represent(comments).as_json)
          end

          desc '提问 [POST /posts/new]'
          params do
            requires :content, type: String, desc: '内容'
          end
          post '/posts/new' do
            user = current_user
            create_body = declared params
            post = user.posts.create!(create_body.to_h)
            wrap_meta(id: post.id)
          end

          desc '查看提问 [GET /posts/show]'
          params do
            requires :postId, type: String, desc: '提问ID'
          end
          get '/posts/show' do
            user = current_user
            post = Post.find_by(id: params.postId)
            wrap_meta(post: post)
          end

          desc 'search提问 [GET /posts/search]'
          params do
            optional :q, type: String, desc: '关键字'
          end
          get '/posts/search' do
            posts = Post.search(params.q, fields: %i[content], match: :text_middle).results
            wrap_meta(posts: posts)
          end
        end
      end
    end
  end
end
