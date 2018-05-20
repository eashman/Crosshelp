# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Sms
        extend ActiveSupport::Concern
        included do
          desc '短信验证码 [POST /sms/sendcode]'
          params do
            requires :phone, type: String, desc: '手机号码'
          end
          post '/sms/sendcode' do
            code = rand(999999).to_s
            p code
            phone = params.phone
            $redis.set("_phoneCode#{phone}",code);
            $redis.expire("_phoneCode#{phone}",3600);
            p $redis.get("_phoneCode#{phone}")
            templateId = Settings.sms.templateId
            result = Utils::Sms.sendCode(phone, templateId, "86",code)
            wrap_meta(msg: '验证码发送成功',result: result)
          end

          desc '登录获取验证码 [POST /sms/login/sendcode]'
          params do
            requires :phone, type: String, desc: '手机号码'
          end
          post '/sms/login/sendcode' do
            user = User.find_by(phone: params.phone)
            if user
              code = rand(999999).to_s
              p code
              phone = params.phone
              $redis.set("_phoneCode#{phone}",code);
              $redis.expire("_phoneCode#{phone}",3600);
              p $redis.get("_phoneCode#{phone}")
              templateId = Settings.sms.templateId
              result = Utils::Sms.sendCode(phone, templateId, "86",code)
              wrap_meta(result: '验证码发送成功')
            else
              return wrap_meta(result: '该手机号不是注册用户。取消/立即注册')
            end
          end
        end
      end
    end
  end
end
