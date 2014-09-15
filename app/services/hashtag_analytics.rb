require 'open-uri'

module HashtagAnalytics
  module_function

  def top_performing(tag_name, top_performing_limit = 3)
    Hashtag.where(name: tag_name).first
    .instagram_medias
    .group_by(&:instagram_user_id)
    .flat_map {|_, instagram_medias| instagram_medias.sort_by(&:engagement).last(top_performing_limit) }
  end

  # To Call:
  # HashtagAnalytics.save_top_performing_images('xxxyx')
  # HashtagAnalytics.save_top_performing_images('taglit')
  def save_top_performing_images(tag_name)
    HashtagScraper.fetch_tag_sequence(tag_name) if Hashtag.where(name: tag_name).empty?

    top_performing(tag_name).each do |instagram_media|
      guarantee_save_instagram_image_to_disk(tag_name, instagram_media)
    end
  end

  def guarantee_save_instagram_image_to_disk(tag_name, instagram_media)
    begin
      save_instagram_image_to_disk(tag_name, instagram_media)
    rescue => e
      sleep 15
      guarantee_save_instagram_image_to_disk(tag_name, instagram_media)
    end
  end

  def save_instagram_image_to_disk(tag_name, instagram_media)
    file_uri = instagram_media.standard_resolution_image_url
    filename = generate_image_name(file_uri,
                                   instagram_id: instagram_media.instagram_id,
                                   username:     instagram_media.instagram_user.username)


    file_loc = [Rails.root,'photoshop_images', tag_name, filename].join('/')
    dir = File.dirname file_loc

    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    open(file_loc, 'wb') do |file|
      file << open(file_uri).read
    end
  end

  def generate_image_name(uri, options)
    key_splitter   = '___'
    param_splitter = '___'
    filename = options.map { |k,v| [k,v].join(param_splitter) }.join(key_splitter)
    file_ext = uri.split('.').last

    [filename, file_ext].join('.')
  end
end
