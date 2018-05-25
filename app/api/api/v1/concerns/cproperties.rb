# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Cproperties
        extend ActiveSupport::Concern
        included do
          desc '添加自定义属性[POST /cproperties/new]'
          params do
            requires :keyname, type: String, desc: '属性名'
            requires :keytype, type: String, desc: '属性类型'
          end
          post '/cproperties/new' do
            user = current_user
            create_body = declared params
            cproperty = Cproperty.create!(create_body.to_h)
            wrap_meta(id: cproperty.id)
          end
        end
      end
    end
  end
end
