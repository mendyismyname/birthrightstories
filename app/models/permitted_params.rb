class PermittedParams < Struct.new(:params)

  KEYS = {
    tags: [:name],
    instagram_user: [:instagram_id,
                     :username,
                     :full_name,
                     :bio,
                     :profile_picture,
                     :website,
                     :media_count,
                     :follows_count,
                     :followed_by_count],

    instagram_media: [:instagram_user_id,
                      :media_type,
                      :users_in_photo,
                      :filter,
                      :tags,
                      :comments,
                      :caption,
                      :likes,
                      :created_time,
                      :images,
                      :instagram_id,
                      :location,
                      :videos]

    # instagram_media: [{ user: {} },
    #                   { tags: [] },
    #                   { likes: [] },
    #                   { images: {} },
    #                   { videos: {} },
    #                   { comments: [] },
    #                   { users_in_photo: [] },
    #                   :filter,
    #                   :caption,
    #                   :location,
    #                   :media_type,
    #                   :created_time,
    #                   :instagram_id,
    #                   :instagram_user_id]
  }
  # Models
  KEYS.each do |model_name, permitted_keys|
    define_method model_name do
      # params.has_key?(model_name) ? params.require(model_name).permit(*permitted_keys) : {}
      params.has_key?(model_name) ? params.require(model_name).permit(*permitted_keys) : {}
    end
  end

  def to_params
    self.params = ActionController::Parameters.new params
    self
  end

  def permit!
    self.params.permit!
  end

end