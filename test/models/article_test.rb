# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  body        :text
#  author      :string
#  image       :string
#  order_index :string
#  hidden      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
