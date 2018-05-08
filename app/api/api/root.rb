# -*- coding: utf-8 -*-
module API
  class Root < Grape::API

    def self.inherited(subclass)
      super

      subclass.instance_eval do
        helpers API::Helper
        format :json

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          raven_capture e
          rack_response({ meta: { status: 3, err: Raven.last_event_id, msg: e.message }, body: {} }.to_json, 200)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
          raven_capture e
          errors = e.record.errors.messages.values
          rack_response({ meta: { status: 3, err: Raven.last_event_id, msg: errors.join(', ') }, body: {} }.to_json, 200)
        end
        rescue_from ActiveRecord::RecordNotFound do |e|
          raven_capture e
          rack_response({ meta: { status: 3, err: Raven.last_event_id, msg: e.message }, body: {} }.to_json, 200)
        end

        rescue_from :all do |e|
          raven_capture e
          rack_response({ meta: { status: 99, err: Raven.last_event_id, msg: '内部服务器错误' }, body: {} }.to_json, 200) if Rails.env.production?
        end
      end
    end
  end
end
