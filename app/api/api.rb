require 'grape-swagger'
module API
end

API::Root.class_eval do
  mount API::V1::Root
  add_swagger_documentation
end
