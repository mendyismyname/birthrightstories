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
#  min_tag_id   :integer
#  max_tag_id   :integer
#  is_active    :boolean          default(TRUE)
#
# Indexes
#
#  index_hashtags_on_slug  (slug) UNIQUE
#

class Hashtag < ActiveRecord::Base

  has_many :instagram_media_hashtags
  has_many :instagram_medias, through: :instagram_media_hashtags

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def min_tag_id
    nil
  end

  def max_tag_id
    nil
  end

  def self.refresh_all_instagram_media
    Hashtag.find_each do |tag|
      DelayedJob.enque InstagramTagScrapeWorker.new(tag.name, tag.min_tag_id, tag.max_tag_id)
    end
  end

  def self.instagram_media_for_hashtag(tag_name)
    Instagram.client.tag_recent_media(tag_name)
  end

  def self.scrape_all
    scrape('birthrightstories')
  end

  def self.scrape(tag_name, min_tag_id=nil, max_tag_id=nil)
    tag = Hashtag.where(name: tag_name).first_or_create

    instagram_media_for_hashtag(tag_name).each do |media_hash|
      # begin
        InstagramMedia.where(instagram_id: media_hash.id).first_or_initialize do |media|

          user = InstagramUser.where(instagram_id: media_hash.user.id).first_or_initialize do |user|
         
            attrs = InstagramMapper::Media.to_instagram_user(media_hash)
            user.update_attributes attrs
          end

          attrs = InstagramMapper::Media.to_instagram_media(media_hash)
          media.assign_attributes attrs
          media.instagram_user = user
          media.hashtags << tag
          

          media.save
        end
      # rescue
      #   puts 'Instagram Scrape Error'
      #   puts media_hash
      # end
    end
  end

end
