module HashtagScraper
  module_function

  def scrape(tag_name, min_tag_id=nil, max_tag_id=nil)
    tag = Hashtag.where(name: tag_name).first_or_create

    Instagram.client.tag_recent_media(tag_name).each do |media_hash|
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

  def update_all
    Hashtag.find_each do |tag|
      DelayedJob.enque InstagramTagScrapeWorker.new(tag.name, tag.min_tag_id, tag.max_tag_id)
    end
  end

  private

  def paginated_scraper(tag_name)
    
  end

end
