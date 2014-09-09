require 'open-uri'

module HashtagAnalytics
  module_function

  def top_performing(tag_name, top_performing_limit = 3)
    Hashtag.where(name: tag_name).first.instagram_medias.group_by(&:instagram_user_id).flat_map do |instagram_user_id, instagram_medias|
      instagram_medias.sort_by(&:engagement).last(top_performing_limit)
    end
  end

  # To Call: 
  # HashtagAnalytics.save_top_performing_images('xxxyx')
  # HashtagAnalytics.save_top_performing_images('taglit')
  def save_top_performing_images(tag_name)
    top_performing(tag_name).each do |instagram_media|
      
      splitter = '__SPLITTER__'
      file_uri = instagram_media.standard_resolution_image_url
      file_ext = file_uri.split('.').last
      filename = ["instagram_id_#{instagram_media.instagram_id}", 
                  "username_#{instagram_media.instagram_user.username}.#{file_ext}"].join(splitter)

      open([Rails.root,'photoshop_images', filename].join('/'), 'wb') do |file|
        file << open(file_uri).read
      end
    end
  end

end

