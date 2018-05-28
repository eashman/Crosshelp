# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Applicants
        extend ActiveSupport::Concern
        included do
          desc '编辑简历个人信息 [POST /applicants/edit]'
          params do
            requires :name, type: String, desc: '姓名'
            requires :sex, type: String, desc: '性别'
            requires :head, type: String, desc: '头像'
            requires :phone, type: String, desc: '手机号码'
            requires :begin_work_date, type: Date, desc: '参加工作时间'
            requires :birthday, type: Date, desc: '出生日期'
            requires :job_status, type: String, desc: '求职状态'
            requires :advantage, type: String, desc: '我的优势'
          end
          post  '/applicants/edit' do
            user = current_user
            create_body = declared params
            applicant = user.applicant.update!(create_body.to_h)
            wrap_meta(applicant: applicant)
          end
        end
      end
    end
  end
end
