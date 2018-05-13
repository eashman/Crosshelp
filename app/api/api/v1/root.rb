module API
  module V1
    class Root < ::API::Root
      version 'v1', using: :accept_version_header
      # Mount points above
      mount API::V1::Users
      mount API::V1::Upload
    end
  end
end
