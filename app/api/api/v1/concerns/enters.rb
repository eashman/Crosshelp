# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Enters
        extend ActiveSupport::Concern
        included do
          desc '获取报名表[POST /enters/new]'
          params do
            requires :activity_id, type: String, desc: '活动ID'
          end
          post '/enters/new' do
            user = current_user
            activity = Activity.find_by(id: params.activity_id)
            cproperties = Cproperty.find_by(ids: activity.cpropertyids) if activity
            wrap_meta(
              cproperties: Entities::CpropertyList.represent(cproperties).as_json
            )
          end

          desc '保存报名表[POST /enters/save]'
          params do
            requires :activityId, type: String, desc: '活动ID'
            requires :name, type: String, desc: '姓名'
            requires :phone, type: String, desc: '手机号码'
            requires :job, type: String, desc: '职位'
            requires :content, type: JSON, desc: '自定义内容'
          end
          post '/enters/save' do
            user = current_user
            enter = Enter.create!(
              activity_id: params.activityId,
              name: params.name,
              phone: params.phone,
              job: params.job.to_json
            )
            ids = user.activityids
            ids.push params.activityId
            ids.uniq!
            user.update!(activityids: ids)
            wrap_meta(enter: enter.id)
          end
        end
      end
    end
  end
end
