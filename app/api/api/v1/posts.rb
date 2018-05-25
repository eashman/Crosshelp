# frozen_string_literal: true

module API
  module V1
    class Posts < Grape::API
      include Concerns::Posts
    end
  end
end
