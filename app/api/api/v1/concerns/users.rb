# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Users
        extend ActiveSupport::Concern
        included do
          desc '登录 [POST /users/login]'
          params do
            optional :phone, type: String, desc: '手机号码'
            optional :open_id, type: String, desc: '微信标识'
          end
          post '/users/login' do
            create_body = declared params
            user = ::User.create!(create_body.to_h)
            wrap_meta(token: user.token)
          end

          desc 'vip用户申请 [PATCH /users/vip]'
          params do
            requires :job, type: Virtus::Attribute::Boolean, desc: '高管'
          end
          patch '/users/vip' do
            @current_user = current_user
            if @current_user.job
              wrap_meta(msg: '该用户已经成为Vip成功')
            else
              @current_user.update!(job: true)
              wrap_meta(msg: '已经申请Vip')
            end
          end

          desc '申请企业会员 [PATCH /users/corporater]'
          params do
            requires :business_licence, type: String, desc: '营业执照'
          end
          patch '/users/corporater' do
            @current_user = current_user
            if @current_user.corporater
              wrap_meta(msg: '该用户已经申请企业会员成功')
            else
              @current_user.update!(corporater: true,
                                    business_licence:params.business_licence)
              wrap_meta(msg: '申请企业会员成功')
            end
          end

          desc '完善个人信息 [PUT /users/perfect]'
          params do
            optional :sex, type: String, desc: '性别'
            optional :birthday, type: String, desc: '出生日期'
            optional :province, type: String, desc: '省'
            optional :city, type: String, desc: '市'
            optional :school, type: String, desc: '毕业院校'
            optional :industry, type: String, desc: '行业'
            optional :summary, type: String, desc: '个人简介'
          end
          put '/users/perfect' do
            @current_user = current_user
            create_body = declared params
            @current_user.update!(create_body.to_h)
            wrap_meta(token: @current_user.token)
          end

          desc '个人信息 [get /users/show]'
          get '/users/show' do
            user = current_user
            wrap_meta(
              user: user
            )
          end
        end
      end
    end
  end
end
