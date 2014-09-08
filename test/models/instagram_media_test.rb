# == Schema Information
#
# Table name: instagram_media
#
#  id                :integer          not null, primary key
#  users_in_photo    :text
#  filter            :string(255)
#  tags              :text
#  comments          :text
#  caption           :text
#  likes             :text
#  created_time      :datetime
#  images            :text
#  instagram_id      :string(255)
#  location          :string(255)
#  videos            :text
#  created_at        :datetime
#  updated_at        :datetime
#  instagram_user_id :string(255)
#  media_type        :string(255)
#  is_displayable    :boolean          default(FALSE)
#

require 'test_helper'

class InstagramMediaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
