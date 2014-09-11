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

class InstagramUser < ActiveRecord::Base

  has_many :instagram_medias
  
  def username_tag
    "@#{username}"
  end

  def uri
    "http://instagram.com/#{username}"
  end
  
end
