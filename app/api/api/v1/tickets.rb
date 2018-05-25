# frozen_string_literal: true

module API
  module V1
    class Tickets < Grape::API
      include Concerns::Tickets
    end
  end
end
