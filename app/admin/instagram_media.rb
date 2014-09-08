ActiveAdmin.register InstagramMedia do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


  index do
    id_column
    column :is_displayable

    column :thumbnail do |instagram_media|
      image_tag(instagram_media.thumbnail_image_url)
    end

    # column :user_full_name do |instagram_media|
    #   instagram_media.instagram_user.full_name
    # end
    column :username do |instagram_media|
      instagram_media.instagram_user.username
    end    

    column :tags
    # column :instagram_id
    column :likes_count
    column :comments_count
    column :users_in_photo_count
    column :caption_text


    #  column :location do |instagram_media|
    #   instagram_media.location[:name][:s]
    # end

    column :created_at
    column :updated_at
    actions
  end

end
