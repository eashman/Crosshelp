module API
  module V1
    class Labels < Grape::API
      include Concerns::Labels
    end
  end
end
