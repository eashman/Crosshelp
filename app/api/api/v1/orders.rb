# frozen_string_literal: true

module API
  module V1
    class Orders < Grape::API
      include Concerns::Orders
    end
  end
end
