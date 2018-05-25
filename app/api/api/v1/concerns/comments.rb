# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Comments
        extend ActiveSupport::Concern
        included do
          desc '回答 [POST /comments/new]'
          params do
            requires :postId, type: String, desc: '提问ID'
            requires :body, type: String, desc: '内容'
          end
          post '/comments/new' do
            user = current_user
            comment = Comment.create!(
              user_id: user.id,
              post_id: params.postId,
              body: params.body
            )
            wrap_meta(id: comment.id)
          end
        end
      end
    end
  end
end
