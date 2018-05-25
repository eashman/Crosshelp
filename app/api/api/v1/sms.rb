# frozen_string_literal: true

module API
  module V1
    class Sms < Grape::API
      include Concerns::Sms
    end
  end
end
