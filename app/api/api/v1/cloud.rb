# frozen_string_literal: true

module API
  module V1
    class Cloud < Grape::API
      include Concerns::Cloud
    end
  end
end
