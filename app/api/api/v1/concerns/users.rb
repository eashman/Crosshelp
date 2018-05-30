# frozen_string_literal: true

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
            requires :type, type: String, values: %w[wx phone], desc: '登陆类型'
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
            wrap_meta(user: user)
          end

          desc '微信注册 [POST /users/wx/register]'
          params do
            requires :open_id, type: String, desc: '微信标识'
            requires :nickname, type: String, desc: '名称'
            requires :headimgurl, type: String, desc: '头像'
            requires :sex, type: String, desc: '性别'
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
            wrap_meta
          end

          desc 'vip用户认证 [POST /users/vip]'
          params do
            optional :badge, type: String, desc: '工牌'
            optional :card, type: String, desc: '名片'
            requires :viper, type: String, values: %w[normal apply], default: 'normal', desc: '状态'
          end
          post '/users/vip' do
            user = current_user
            create_body = declared params
            user.update!(create_body.to_h)
            wrap_meta(msg: '已提交后台审核')
          end

          desc '用户申请企业管理员 [POST /users/authentication]'
          post '/users/authentication' do
            user = current_user
          end

          desc '企业开通招聘权限 [POST /users/recruit]'
          post '/users/recruit' do
            user = current_user
          end

          desc '增加招聘官 [POST /users/recruit/add]'
          params do
            requires :userId, type: String, desc: '员工ID'
          end
          post '/users/recruit/add' do
            user = current_user
            if user.recruit == 'superadmin'
              company = user.company
              staff = company.users.find_by(id: params.userId)
              return wrap_meta(msg: '该公司不存在该员工') unless staff
              staff.update!(recruit: 'admin')
              wrap_meta(name: staff.name)
            end
          end

          desc '移除招聘官 [POST /users/recruit/remove]'
          params do
            requires :userId, type: String, desc: '员工ID'
          end
          post '/users/recruit/remove' do
            user = current_user
            if user.recruit == 'superadmin'
              company = user.company
              staff = company.users.find_by(id: params.userId)
              return wrap_meta(msg: '该公司不存在该员工') unless staff
              staff.update!(recruit: 'normal')
              wrap_meta(name: staff.name)
            end
          end

          desc '招聘官列表 [GET /users/recruit/list]'
          get '/users/recruit/list' do
            user = current_user
            if user.recruit == 'superadmin'
              company = user.company
              staffs = company.users.where(recruit: 'admin').only(:name)
              wrap_meta(staffs: staffs)
            end
          end

          desc '企业管理员增加员工vip [POST /users/viper/add]'
          params do
            requires :userId, type: String, desc: '员工ID'
          end
          post '/users/viper/add' do
            user = current_user
            count = user.vipercount
            if (user.authentication == 'success') && (user.vipercount > 0)
              staff = User.find_by(id: params.userId)
              staff.update!(viper: 'agree')
              count -= 1
              user.update!(vipercount: count)
              wrap_meta(msg: '成功')
            else
              wrap_meta(msg: '你未是企业管理员')
            end
          end

          desc '转让管理员权限 [PATCH /users/authentication/assignment]'
          params do
            requires :userId, type: String, desc: '员工ID'
          end
          patch '/users/authentication/assignment' do
            user = current_user
            if user.authentication == 'success'
              company = user.company
              staff = company.users.find_by(id: params.userId)
              return wrap_meta(msg: '该公司不存在该员工') unless staff
              staff.update!(authentication: 'success')
              user.update!(authentication: 'normal')
            else
              wrap_meta(msg: '你未是企业管理员')
            end
          end

          desc '完善个人信息 [PUT /users/perfect]'
          params do
            requires :name, type: String, desc: '名字'
            requires :industry, type: String, desc: '行业'
            requires :profession, type: String, desc: '职业'
          end
          put '/users/perfect' do
            user = current_user
            create_body = declared params
            user.update!(create_body.to_h)
            wrap_meta
          end

          desc '编辑个人信息 [PUT /users/edit]'
          params do
            optional :sex, type: String, desc: '性别'
            optional :birthday, type: String, desc: '出生日期'
            optional :province, type: String, desc: '省'
            optional :city, type: String, desc: '市'
            optional :school, type: String, desc: '毕业院校'
            optional :summary, type: String, desc: '个人简介'
            requires :company, type: Hash do
              requires :name, type: String, desc: '公司名称'
            end
          end
          put '/users/edit' do
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
