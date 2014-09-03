# == Schema Information
#
# Table name: instagram_users
#
#  id                :integer          not null, primary key
#  instagram_id      :integer
#  username          :string(255)
#  full_name         :string(255)
#  bio               :text
#  profile_picture   :string(255)
#  website           :string(255)
#  media_count       :integer
#  follows_count     :integer
#  followed_by_count :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class InstagramUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
