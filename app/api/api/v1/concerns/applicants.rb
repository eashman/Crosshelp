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

          desc '添加求职意向 [POST /applicants/expectjobs]'
          params do
            requires :industry, type: String, desc: '期望行业'
            requires :job, type: String, desc: '期望职位'
            requires :city, type: String, desc: '工作城市'
            requires :salary, type: String, desc: '期望薪资'
          end
          post  '/applicants/expectjobs' do
            user = current_user
            create_body = declared params
            applicant = user.applicant
            expectjob = applicant.expectjobs.create!(create_body.to_h)
            wrap_meta(expectjob: expectjob)
          end

          desc '添加工作经验 [POST /applicants/workexperiences]'
          params do
            requires :position, type: String, desc: '职位'
            requires :department, type: String, desc: '部门'
            requires :company_name, type: String, desc: '公司名称'
            requires :begin_date, type: Date, desc: '时间段开始时间'
            requires :end_date, type: Date, desc: '时间段结束时间'
            requires :job_content, type: String, desc: '工作内容'
            requires :performance, type: String, desc: '工作业绩'
          end
          post  '/applicants/workexperiences' do
            user = current_user
            create_body = declared params
            applicant = user.applicant
            workexperience = applicant.workexperiences.create!(create_body.to_h)
            wrap_meta(workexperience: workexperience)
          end

          desc '添加项目经验 [POST /applicants/projectexperiences]'
          params do
            requires :project_name, type: String, desc: '项目名称'
            requires :project_connect, type: String, desc: '项目衔接'
            requires :employment, type: String, desc: '人数'
            requires :role, type: String, desc: '担任角色'
            requires :begin_date, type: Date, desc: '时间段开始时间'
            requires :end_date, type: Date, desc: '时间段结束时间'
            requires :project_content, type: String, desc: '项目内容'
            requires :performance, type: String, desc: '项目业绩'
          end
          post  '/applicants/projectexperiences' do
            user = current_user
            create_body = declared params
            applicant = user.applicant
            projectexperience = applicant.projectexperiences.create!(create_body.to_h)
            wrap_meta(projectexperience: projectexperience)
          end

          desc '添加教育经验 [POST /applicants/educationexperiences]'
          params do
            requires :school, type: String, desc: '学校'
            requires :major, type: String, desc: '专业'
            requires :education, type: String, desc: '学历'
            requires :begin_date, type: Date, desc: '时间段开始时间'
            requires :end_date, type: Date, desc: '时间段结束时间'
            requires :experience, type: String, desc: '在校经历'
          end
          post  '/applicants/educationexperiences' do
            user = current_user
            create_body = declared params
            applicant = user.applicant
            educationexperience = applicant.educationexperiences.create!(create_body.to_h)
            wrap_meta(educationexperience: educationexperience)
          end
        end
      end
    end
  end
end
