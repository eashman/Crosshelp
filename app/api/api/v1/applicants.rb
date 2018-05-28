# frozen_string_literal: true

module API
  module V1
    class Applicants < Grape::API
      include Concerns::Applicants
    end
  end
end
