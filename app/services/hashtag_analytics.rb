require 'open-uri'

# HashtagAnalytics.save_all_tags_images([
#   'yaeladventures',
#   'ezrataglit',
#   'ezraworld',
#   'israeloutdoors',
#   'israelexperts',
#   'gokesher',
#   'israelfreespirit',
#   'hillel',
#   'getmoreisrael',
#   'israelforfree',
#   'YOLOisrael',
#   'awesomeisrael',
#   'shorashim',
#   'israelisamazing',
#   'amazingisrael',
#   'mayanotisrael',
#   'mayanot',
#   'toisraelnow',
#   'youngjudea',
#   'sachlav'])

module HashtagAnalytics
  module_function

  def top_performing(tag_name, top_performing_limit = 3)
    Hashtag.where(name: tag_name).first
    .instagram_medias
    .group_by(&:instagram_user_id)
    .flat_map {|_, instagram_medias| instagram_medias.sort_by(&:engagement).last(top_performing_limit) }
  end

  def save_all_tags_images(tag_names)
    tag_names.each { |tag_name| save_all_tag_images tag_name }
  end

  def save_all_tag_images(tag_name)
    HashtagScraper.fetch_tag_sequence(tag_name) # if Hashtag.where(name: tag_name).empty?
    
    images_by_user = Hashtag.where(name: tag_name)
      .first
      .instagram_medias
      .group_by(&:instagram_user_id)

    images_by_user.each do |instagram_user_id, instagram_medias|
      instagram_medias.each_with_index do |instagram_media, index|
        guarantee_save_instagram_image_to_disk(index, tag_name, instagram_media)
      end
    end
  end

  # To Call:
  # HashtagAnalytics.save_top_performing_images('xxxyx')
  # HashtagAnalytics.save_top_performing_images('taglit')
  def save_top_performing_images(tag_name)
    HashtagScraper.fetch_tag_sequence(tag_name) if Hashtag.where(name: tag_name).empty?

    top_performing(tag_name).each do |instagram_media|
      guarantee_save_instagram_image_to_disk(index, tag_name, instagram_media)
    end
  end

  def guarantee_save_instagram_image_to_disk(index, tag_name, instagram_media, attempt=0)
    return if attempt > 10
    begin
      puts tag_name
      puts instagram_media
      puts index
      save_instagram_image_to_disk(index, tag_name, instagram_media)
    rescue => e
      puts 'ERROR'
      puts 'ERROR'
      puts 'ERROR'
      puts e
      puts 'ERROR'
      puts 'ERROR'
      puts 'ERROR'
      puts instagram_media
      puts index

      sleep 15      
      guarantee_save_instagram_image_to_disk(index, tag_name, instagram_media, attempt + 1)
    end
  end

  def save_instagram_image_to_disk(index, tag_name, instagram_media)
    file_uri = instagram_media.standard_resolution_image_url
    filename = generate_seq_image_name(index,
                                       file_uri,
                                       instagram_id: instagram_media.instagram_id,
                                       username:     instagram_media.instagram_user.username)


    file_loc = [Rails.root,'photoshop_images', tag_name, filename].join('/')
    dir = File.dirname file_loc

    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    open(file_loc, 'wb') do |file|
      file << open(file_uri).read
    end
  end

  def generate_seq_image_name(index, uri, options)
    file_ext = uri.split('.').last
    [options[:username], '_', index, file_ext].join('.')
  end

  def generate_image_name(uri, options)
    key_splitter   = '_'
    param_splitter = '_'
    filename = options.map { |k,v| [k,v].join(param_splitter) }.join(key_splitter)
    file_ext = uri.split('.').last

    [filename, file_ext].join('.')
  end
end
