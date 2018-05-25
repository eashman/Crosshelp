# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  summary    :text
#  logo       :string
#  address    :string
#  industry   :string
#  website    :string
#  mailbox    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
