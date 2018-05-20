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
            optional :code, type: String, desc: '验证码'
            requires :type, type: String, values: %w(wx phone), desc: '登陆类型'
          end
          post '/users/login' do
            if params.type == 'wx'
              user = User.find_by(open_id: params.open_id)
            else
              if $redis.get("_phoneCode#{params.phone}") == params.code
                user = User.find_by(phone: params.phone)
                rerurn wrap_meta(msg: '未注册用户') unless user
              else
                return wrap_meta(msg: '验证码错误')
              end
            end
            user.regenerate_token
            wrap_meta(token: user.token)
          end

          desc '微信注册 [POST /users/wx/register]'
          params do
            requires :open_id, type: String, desc: '微信标识'
            requires :nickname, type: String, desc: '名称'
            requires :headimgurl, type: String, desc: '名称'
            requires :sex, type: String, desc: '名称'
          end
          post '/users/wx/register' do
            user = User.find_or_create_by(open_id: params.open_id)
            user.name = params.name if user.name.nil?
            user.photo = params.headimgurl if user.photo.nil?
            user.sex = params.sex if user.sex.nil?
            user.save!
            user.regenerate_token
            wrap_meta(token: user.token)
          end

          desc '微信绑定手机号[POST /users/wx/bind/phone]'
          params do
            requires :phone, type: String, desc: '手机号码'
            requires :open_id, type: String, desc: '微信标识'
            requires :code, type: String, desc: '验证码'
          end
          post '/users/wx/bind/phone' do
            if $redis.get("_phoneCode#{params.phone}") == params.code
              user = User.find_by(open_id: params.open_id)
              if user
                user.update!(phone: params.phone)
                return wrap_meta(msg: '绑定手机号码成功!')
              else
                return wrap_meta(msg: '未找到openid对应的用户')
              end
            else
              return wrap_meta(msg: '验证码错误')
            end
          end

          desc '手机号码注册[POST /users/phone/register]'
          params do
            requires :phone, type: String, desc: '手机号码'
            requires :code, type: String, desc: '验证码'
          end
          post '/users/phone/register' do
            if $redis.get("_phoneCode#{params.phone}") == params.code
              user = User.find_or_create_by(phone: params.phone)
              return wrap_meta(token: user.token)
            else
              return wrap_meta(msg: '验证码错误')
            end
          end

          desc '头像 [PATCH /users/photo]'
          params do
             requires :photo, type: String, desc: '头像'
          end
          patch '/users/photo' do
            user = current_user
            user.update!(photo: params.photo)
            wrap_meta()
          end

          desc 'vip用户认证 [POST /users/vip]'
          params do
            optional :badge, type: String, desc: '工牌'
            optional :card, type: String, desc: '名片'
            requires :viper, type: String, values: %w(normal apply), default: 'normal',desc: '状态'
          end
          post '/users/vip' do
            user = current_user
            create_body = declared params
            user.update!(create_body.to_h)
            wrap_meta(msg: '已提交后台审核')
          end

          desc '完善个人信息 [PUT /users/perfect]'
          params do
            optional :sex, type: String, desc: '性别'
            optional :birthday, type: String, desc: '出生日期'
            optional :province, type: String, desc: '省'
            optional :city, type: String, desc: '市'
            optional :school, type: String, desc: '毕业院校'
            requires :industry, type: String, desc: '行业'
            requires :profession, type: String, desc: '职业'
            optional :summary, type: String, desc: '个人简介'
            optional :holdoffice, type: String, desc: '担任职位'
            optional :remark, type: String, desc: '备注'
            requires :company, type: Hash do
              requires :name, type: String, desc: '公司名称'
            end
          end
          put '/users/perfect' do
            user = current_user
            create_body = declared params
            user.update!(create_body.to_h)
            if user.corporater
              wrap_meta(msg: '企业已认证名称禁止修改!')
            else
              user.build_company(name: params.company.name)
            end
            wrap_meta(msg: '完善成功')
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
