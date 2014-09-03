# == Schema Information
#
# Table name: instagram_media_hashtags
#
#  id                 :integer          not null, primary key
#  instagram_media_id :integer
#  hashtag_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_instagram_media_hashtags_on_hashtag_id  (hashtag_id)
#

require 'test_helper'

class InstagramMediaHashtagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
