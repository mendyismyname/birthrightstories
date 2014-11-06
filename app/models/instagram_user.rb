# == Schema Information
#
# Table name: instagram_users
#
#  id                :integer          not null, primary key
#  instagram_id      :integer
#  username          :string(255)
#  full_name         :text
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
  
  def refresh
    response = Instagram.client.user(instagram_id)
    attrs = InstagramMapper::Media.to_instagram_user(Hashie::Mash.new(user: response))

    self.profile_picture = attrs[:profile_picture]
    save
    
    self.bio             = attrs[:bio]
    self.website         = attrs[:website]
    self.full_name       = attrs[:full_name]
    save
  end

  def self.refresh_all
    InstagramUser.find_each do |user|
      begin
        user.refresh
      rescue
        puts "Instagram User Scrape Error"
        puts self
      end
    end
  end

end
