# frozen_string_literal: true

module API
  module V1
    class Comments < Grape::API
      include Concerns::Comments
    end
  end
end
