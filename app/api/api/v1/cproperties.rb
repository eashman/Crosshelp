# frozen_string_literal: true

module API
  module V1
    class Cproperties < Grape::API
      include Concerns::Cproperties
    end
  end
end
