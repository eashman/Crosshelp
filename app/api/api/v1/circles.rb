# frozen_string_literal: true

module API
  module V1
    class Circles < Grape::API
      include Concerns::Circles
    end
  end
end
