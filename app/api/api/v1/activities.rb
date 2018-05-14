module API
  module V1
    class Activities < Grape::API
      include Concerns::Activities
    end
  end
end
