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
          end
        end
      end
    end
  end
end
