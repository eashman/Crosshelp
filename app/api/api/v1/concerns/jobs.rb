# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Jobs
        extend ActiveSupport::Concern
        included do
          desc '行业与职位 [GET /jobs]'
          get '/jobs' do
            wrap_meta(
              jobs: Entities::JobList.represent(Job.order(:sort)).as_json
            )
          end

          desc '行业与职位的子集 [GET /jobs/children]'
          params do
            requires :parent_id, type: String, desc: '父ID'
          end
          get '/jobs/children' do
            jobs = Job.where(parent_id: params.parent_id)
            wrap_meta(
              jobs: Entities::JobList.represent(jobs).as_json
            )
          end
        end
      end
    end
  end
end
