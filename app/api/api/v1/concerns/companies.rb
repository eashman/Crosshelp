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
            company = user.companies.create!(create_body.to_h)
            wrap_meta(company: company)
          end
        end
      end
    end
  end
end
