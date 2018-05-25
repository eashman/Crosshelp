# frozen_string_literal: true

module API
  module V1
    class Friends < Grape::API
      include Concerns::Friends
    end
  end
end
