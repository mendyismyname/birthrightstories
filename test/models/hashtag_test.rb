# == Schema Information
#
# Table name: hashtags
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  refreshed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  slug         :string(255)
#
# Indexes
#
#  index_hashtags_on_slug  (slug) UNIQUE
#

require 'test_helper'

class HashtagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
