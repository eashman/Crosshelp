# frozen_string_literal: true

module API
  module V1
    class Upload < Grape::API
      include Concerns::Upload
    end
  end
end
