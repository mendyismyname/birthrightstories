require 'open-uri'

module HashtagAnalytics
  module_function

  def top_performing(tag_name, top_performing_limit = 3)
    top_performing = Hashtag.where(name: tag_name).first.instagram_medias.find_each.group_by(&:instagram_user_id).map do |instagram_user_id, instagram_medias|
      instagram_medias.sort_by(&:engagement).first(top_performing_limit)
    end
    top_performing.flatten
  end

  # To Call: 
  # HashtagAnalytics.save_top_performing_images('xxxyx')
  def save_top_performing_images(tag_name)
    top_performing(tag_name).each do |instagram_media|
      
      file_uri = instagram_media.standard_resolution_image_url
      file_ext = file_uri.split('.').last
      filename = "id_#{instagram_media.id}_username_#{instagram_media.instagram_user.username}.#{file_ext}"

      open([Rails.root,'photoshop_images', filename].join('/'), 'wb') do |file|
        file << open(file_uri).read
      end

    end
  end

end

