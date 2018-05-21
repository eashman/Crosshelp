# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Companies
        extend ActiveSupport::Concern
        included do
          desc '完善公司信息 [POST /companies/perfect]'
          params do
            requires :name, type: String, desc: '公司名称'
            requires :logo,  type: String, desc: 'logo'
            requires :address,  type: String, desc: '地址'
            requires :industry,  type: String, desc: '行业'
            requires :website,  type: String, desc: '网址'
            requires :mailbox,  type: String, desc: '邮箱'
            requires :summary,  type: String, desc: '公司简介'
          end
          post '/companies/perfect' do
            user = current_user
            create_body = declared params
            if user.corporater == 'agree'
              wrap_meta(msg: '该企业已经认证成功，信息禁止修改')
            else
             company = user.company.update!(create_body.to_h)
             wrap_meta(company: company)
           end
          end

          desc '申请认证企业 [PATCH /companies/corporater]'
          params do
            requires :logo,  type: String, desc: 'logo'
            requires :industry,  type: String, desc: '行业'
            requires :business_licence, type: String, desc: '营业执照'
            requires :corporater, type: String, values: %w(normal apply), default: 'normal',desc: '状态'
          end
          patch '/users/corporater' do
            user = current_user
            create_body = declared params
            if user.corporater == 'agree'
              wrap_meta(msg: '该公司已经认证成功')
            else
              user.company.update!(create_body.to_h)
              wrap_meta(msg: '已提交后台审核')
            end
          end

          desc '认证企业的员工列表 [GET /companies/users/list]'
          params do
            requires :companyId,  type: String, desc: '企业ID'
          end
          get '/companies/users/list' do
            user = current_user
            company = Company.find_by(id: params.companyId)
            users = company.users.where('users.corporater = true') if company
            wrap_meta(
              users: Entities::UserList.represent(users).as_json
            )
          end


          desc '编辑员工信息 [PUT /companies/users/perfect]'
          params do
            requires :userId, type: String, desc: '员工ID'
            requires :holdoffice, type: String, desc: '担任职位'
            requires :remark, type: String, desc: '备注'
          end
          put '/companies/users/perfect' do
            user = current_user
            create_body = declared params
            staff = User.find_by(id: params.userId)
            staff.update!(create_body.to_h)
            wrap_meta(staff: staff)
          end
        end
      end
    end
  end
end
