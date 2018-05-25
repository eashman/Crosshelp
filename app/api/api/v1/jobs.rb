# frozen_string_literal: true

module API
  module V1
    class Jobs < Grape::API
      include Concerns::Jobs
    end
  end
end
