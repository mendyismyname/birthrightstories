class InstagramTagScrapeWorker < Struct.new(:tag_name, :min_tag_id, :max_tag_id)

  def perform
    tag = Tag.first_or_create(name: tag_name)
    Instagram.client.tag_recent_media(tag_name).each do |media_hash|
      InstagramMedia.where(instagram_id: media_hash.id).first_or_initialize do |media|
        
        user = InstagramUser.where(instagram_id: media_hash.user.id).first_or_initialize do |user|
          
          attrs = InstagramMapper::Media.to_instagram_user(media_hash)
          user.update_attributes attrs
        end

        attrs = InstagramMapper::Media.to_instagram_media(media_hash)
        puts attrs
        media.assign_attributes attrs
        media.instagram_user = user
        media.hashtags << tag
        media.save
      end
    end
  end

end
