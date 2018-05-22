# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Activities
        extend ActiveSupport::Concern
        included do
          desc '获取活动 [GET /activities]'
          get '/activities'  do
            user = current_user
            activities = user.activities
            wrap_meta(
              activities: Entities::ActivityList.represent(activities).as_json
            )
          end

          desc '发布活动[POST /activities/new]'
          params do
            requires :poster, type: String, desc: '主题海报'
            requires :title,  type: String, desc: '主题'
            requires :address,  type: String, desc: '地址'
            requires :begin_time,  type: DateTime, desc: '活动开始时间'
            requires :end_time,    type: DateTime, desc: '活动结束时间'
          end
          post '/activities/new' do
            user = current_user
            create_body = declared params
            activity = user.activities.create!(create_body.to_h)
            wrap_meta(activity: activity)
          end
        end
      end
    end
  end
end
