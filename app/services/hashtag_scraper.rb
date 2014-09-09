module HashtagScraper
  module_function

  def update_hashtag_metadata(tag_name)
    tag = Hashtag.where(name: tag_name).first_or_initialize
    tag.update_attributes instagram_count: Instagram.client.tag(tag_name).media_count
    tag
  end

  def fetch_tag_sequence(tag_name)
    tag = update_hashtag_metadata(tag_name)


    # index = 1;

    loop do
      tags = scrape tag_name, options ||= {min_tag_id: tag.min_tag_id || 0, max_tag_id: tag.max_tag_id}
      next_url = tags.pagination.next_url

      break unless next_url

      options = Hash[next_url.split('?').last.split('&').map {|x| x.split('=')}].symbolize_keys.slice(:min_tag_id, :max_tag_id)

      # puts '----------------------------------------------------'
      # puts next_url
      # puts Hash[next_url.split('?').last.split('&').map {|x| x.split('=')}]
      # puts options
      # puts '----------------------------------------------------'


      tag.update_attributes options
      # index += 1
      # break if index > 7

      # puts '====================================================='
      
      # puts index
      
      # puts tags.pagination
      # puts options.compact
      # puts '====================================================='
    end
  end

  def scrape(tag_name, options={})
    tag = Hashtag.where(name: tag_name).first_or_create

    # options = { 
    #   min_tag_id: options[:min_tag_id], 
    #   max_tag_id: options[:max_tag_id]
    # }
    
    Instagram.client.tag_recent_media(tag_name, options.compact).each do |media_hash|
      begin
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
      rescue
        puts 'Instagram Scrape Error'
        puts media_hash
      end
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
