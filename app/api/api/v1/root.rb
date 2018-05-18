module API
  module V1
    class Root < ::API::Root
      version 'v1', using: :accept_version_header
      # Mount points above
      mount API::V1::Users
      mount API::V1::Upload
      mount API::V1::Labels
      mount API::V1::Sms
      mount API::V1::Activities
      mount API::V1::Posts
      mount API::V1::Friends
      mount API::V1::Jobs
      mount API::V1::Circles
    end
  end
end
