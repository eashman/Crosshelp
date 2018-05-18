module API
  module V1
    class Groups < Grape::API
      include Concerns::Groups
    end
  end
end
