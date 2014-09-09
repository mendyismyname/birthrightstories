# == Schema Information
#
# Table name: hashtags
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  refreshed_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  slug            :string(255)
#  min_tag_id      :string(255)      default("0")
#  max_tag_id      :string(255)
#  is_active       :boolean          default(TRUE)
#  instagram_count :integer          default(0)
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
