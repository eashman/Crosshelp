# frozen_string_literal: true

module API
  module V1
    class Companies < Grape::API
      include Concerns::Companies
    end
  end
end
