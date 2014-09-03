module InstagramMapper

  module Media
    module_function

    def to_instagram_media_hash(raw_media)
      instagram_media              = raw_media.clone.slice *PermittedParams::KEYS[:instagram_media]
      instagram_media.instagram_id = raw_media.id
      instagram_media.media_type   = raw_media.type
      instagram_media.likes        = raw_media.likes.data
      instagram_media.comments     = raw_media.comments.data
      instagram_media.images     ||= {}
      instagram_media.caption    ||= {}
      instagram_media.videos     ||= {}
      instagram_media.location   ||= {}
      instagram_media.created_time = DateTime.strptime(raw_media.created_time,'%s') # handle unix time converstion
      instagram_media.to_h.deep_symbolize_keys
    end

    def to_instagram_user_hash(raw_media)
      instagram_user              = raw_media.user.clone
      instagram_user.instagram_id = instagram_user.delete :id
      instagram_user.to_h.deep_symbolize_keys
    end   

    def to_instagram_media(raw_media)
      instagram_media = to_instagram_media_hash(raw_media)
      # PermittedParams.new(instagram_media: instagram_media.to_h.deep_symbolize_keys).to_params.instagram_media
      params = PermittedParams.new(instagram_media.to_h.deep_symbolize_keys).to_params.permit!      
    end
    
    def to_instagram_user(raw_media)
      instagram_user = to_instagram_user_hash(raw_media)
      params = PermittedParams.new(instagram_user: instagram_user.to_h.deep_symbolize_keys).to_params.instagram_user
    end

  end

end