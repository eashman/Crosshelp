# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Enters
        extend ActiveSupport::Concern
        included do
          desc '获取报名表[POST /enters/new]'
          params do
            requires :activityId, type: String, desc: '活动ID'
          end
          post '/enters/new' do
            user = current_user
            activity = Activity.find_by(id: params.activityId)
            cproperties = Cproperty.find(activity.cpropertyids) if activity
            wrap_meta(
              cproperties: Entities::CpropertyList.represent(cproperties).as_json
            )
          end

          desc '报名信息 [GET /enters/personal]'
          params do
            requires :enterId, type: String, desc: '报名ID'
          end
          get '/enters/personal' do
            user = current_user
            enter = Enter.find_by(id: params.enterId)
            wrap_meta(enter: enter)
          end

          desc '报名名单 [GET /enters/list]'
          params do
            requires :activityId, type: String, desc: '活动ID'
          end
          get '/enters/list' do
            user = current_user
            activity = Activity.find_by(id: params.activityId)
            enters = activity.enters if activity
            wrap_meta(
              enters: Entities::EnterList.represent(enters).as_json
            )
          end

          desc '保存报名表[POST /enters/save]'
          params do
            requires :activityId, type: String, desc: '活动ID'
            requires :activityfeeId, type: String, desc: '费用ID'
            requires :name, type: String, desc: '姓名'
            requires :phone, type: String, desc: '手机号码'
            requires :job, type: String, desc: '职位'
            optional :content, type: JSON, desc: '自定义内容'
          end
          post '/enters/save' do
            user = current_user
            activity = Activity.find_by(id: params.activitId)
            activityfee = Activityfee.find_by(id: activityfeeId)
            enter = Enter.create!(
              activity_id: params.activityId,
              activityfee_id: params.activityfeeId,
              name: params.name,
              phone: params.phone,
              job: params.job,
              content: params.content.to_json
            )
            order = user.orders.create!(
              name: activity.name,
              sum: activityfee.money,
              factsum: activityfee.money
            )
            ids = user.activityids
            ids.push params.activityId
            ids.uniq!
            user.update!(activityids: ids)
            wrap_meta(enter_id: enter.id, order_id: order.id)
          end
        end
      end
    end
  end
end
