# frozen_string_literal: true

module API
  module V1
    class Jobmanages < Grape::API
      include Concerns::Jobmanages
    end
  end
end
