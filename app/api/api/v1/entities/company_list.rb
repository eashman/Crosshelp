# frozen_string_literal: true

module API
  module V1
    module Entities
      class CompanyList < Grape::Entity
        expose :id, :name, :logo, :address
        expose :count do |sp, _|
           sp.user.jobmanage.count
         end
      end
    end
  end
end
