module API
  module V1
    class Enters < Grape::API
      include Concerns::Enters
    end
  end
end
