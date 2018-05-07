module API
  module V1
    class Root < ::API::Root
      version 'v1', using: :accept_version_header
      # Mount points above
    end
  end
end
