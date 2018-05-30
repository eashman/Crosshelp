class Jobmanage < ApplicationRecord
  belongs_to :user, optional: true
end
