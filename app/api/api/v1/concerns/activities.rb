# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Activities
        extend ActiveSupport::Concern
        included do
          desc '获取活动信息 [GET /activities/fetch]'
          params do
            requires :activityId, type: String, desc: '活动ID'
          end
          get '/activities/fetch'  do
            user = current_user
            activity = Activity.find_by(id: params.activityId)
            wrap_meta(activity: activity)
          end

          desc '用户发布的活动[GET /activities/users/publish]'
          get '/activities/users/publish'  do
            user = current_user
            activities = user.activities
            wrap_meta(
              activities: Entities::ActivityList.represent(activities).as_json
            )
          end

          desc '用户参与的活动[GET /activities/users/partake]'
          get '/activities/users/publish'  do
            user = current_user
            activities = Activity.find(user.activityids)
            wrap_meta(
              activities: Entities::ActivityList.represent(activities).as_json
            )
          end

          desc '发布活动[POST /activities/new]'
          params do
            requires :poster, type: String, desc: '主题海报'
            requires :title,  type: String, desc: '主题'
            requires :address,  type: String, desc: '地址'
            requires :body,  type: String, desc: '活动简介'
            requires :begin_time,  type: DateTime, desc: '活动开始时间'
            requires :end_time, type: DateTime, desc: '活动结束时间'
            requires :deadline, type: DateTime, desc: '活动报名截止时间'
            optional :activityfees, type: Array, desc:'费用' do
              requires :name, type: String, desc: '名称'
              requires :money, type: BigDecimal, desc: '金额'
              requires :quota, type: Integer, desc: '名额'
            end
            optional :cpropertyids, type: Array[Integer], default: [], desc:'自定义属性ID'
            optional :itemids, type: Array[Integer], default: [], desc:'标签IDs'
          end
          post '/activities/new' do
            user = current_user
            activity = user.activities.create!(
              poster: params.poster,
              title: params.title,
              address: params.address,
              body: params.body,
              begin_time: params.begin_time,
              end_time: params.end_time,
              deadline: params.deadline,
              cpropertyids: params.cpropertyids.to_a,
              itemids: params.itemids.to_a
            )
            declared(params, include_missing: false).activityfees.to_a.each do |sp|
              Activityfee.create!(sp.merge(activity_id: activity.id).to_h)
            end
            wrap_meta(id: activity.id)
          end
        end
      end
    end
  end
end
