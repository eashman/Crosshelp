# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Jobmanages
        extend ActiveSupport::Concern
        included do
          desc '发布职位 [POST /jobmanages/new]'
          params do
            requires :company_name, type: String, desc: '公司信息'
            requires :position, type: String, desc: '职位类型'
            requires :address, type: String, desc: '工作地点'
            requires :kind, type: String, desc: '工作性质'
            requires :ability, type: String, desc: '工作要求'
            requires :salary, type: String, desc: '薪资范围'
            requires :experience, type: String, desc: '经验要求'
            requires :education, type: String, desc: '最低学历'
            requires :workcontent, type: String, desc: '职位描述'
          end
          post '/jobmanages/new' do
            user = current_user
            return wrap_meta('无发布职位的权限') if user.recruit == 'normal'
            create_body = declared params
            jobmanage = user.jobmanages.create!(create_body.to_h)
            wrap_meta(id: jobmanage.id)
          end

          desc '编辑职位 [PUT /jobmanages/edit]'
          params do
            requires :kind, type: String, desc: '工作性质'
            requires :ability, type: String, desc: '工作要求'
            requires :salary, type: String, desc: '薪资范围'
            requires :experience, type: String, desc: '经验要求'
            requires :education, type: String, desc: '最低学历'
            requires :workcontent, type: String, desc: '职位描述'
          end
          put '/jobmanages/edit' do
            user = current_user
            return wrap_meta('无发布职位的权限') if user.recruit == 'normal'
            create_body = declared params
            jobmanage = user.jobmanages.update!(create_body.to_h)
            wrap_meta(id: jobmanage.id)
          end

          desc '投递职位 [POST /jobmanages/follow]'
          params do
            requires :jobmanageId,type: String ,desc: '职位ID'
          end
          post '/jobmanages/follow' do
            user = current_user
            jobmanage = Jobmanage.find_by(id: params.jobmanageId)
            applicant = user.applicant
            applicant.jobmanages << jobmanage
            wrap_meta(id: jobmanage.id)
          end

          desc '查看职位 [GET /jobmanages/show]'
          params do
            requires :jobmanageId, type: String, desc: '职位ID'
          end
          get '/jobmanages/show' do
            user = current_user
            id = params.jobmanageId
            jobmanage = Jobmanage.find_by(id: id,user_id: user.id)
            wrap_meta(jobmanage: jobmanage)
          end

          desc '删除职位 [DELETE /jobmanages/destroy]'
          params do
            requires :jobmanageIds, type: Array[Integer], default: [], desc: '职位ID组'
          end
          delete '/jobmanages/destroy' do
            user = current_user
            ids = params.jobmanageIds
            jobmanages = user.jobmanages.find(ids)
            orm_ids = jobmanages.pluck(:id)
            Jobmanage.destroy(orm_ids)
            wrap_meta(ids: orm_ids)
          end
        end
      end
    end
  end
end
