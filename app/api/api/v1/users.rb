# frozen_string_literal: true

module API
  module V1
    class Users < Grape::API
      include Concerns::Users
    end
  end
end
