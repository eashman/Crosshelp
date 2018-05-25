# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Labels
        extend ActiveSupport::Concern
        included do
          desc '查看标签 [GET /labels]'
          get '/labels' do
            wrap_meta(
              labels: Entities::LabelList.represent(Label.order(:sort)).as_json
            )
          end
        end
      end
    end
  end
end
