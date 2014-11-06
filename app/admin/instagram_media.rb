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



  batch_action :display_toggle do |selection|
    InstagramMedia.find(selection).each do |instagram_media|
      instagram_media.toggle_display
    end
    redirect_to admin_instagram_media_path, notice: "Updated!"
  end

  batch_action :display_enable do |selection|
    InstagramMedia.find(selection).each do |instagram_media|
      instagram_media.is_displayable = true
      instagram_media.save
    end
    redirect_to admin_instagram_media_path, notice: "Updated!"
  end  

  batch_action :display_disable do |selection|
    InstagramMedia.find(selection).each do |instagram_media|
      instagram_media.is_displayable = false
      instagram_media.save
    end
    redirect_to admin_instagram_media_path, notice: "Updated!"
  end    

  member_action :toggle_display, method: :put do
    instagram_media = InstagramMedia.find(params[:id])
    instagram_media.toggle_display
    redirect_to admin_instagram_media_path, notice: "Updated!"
  end

  index do
    selectable_column
    id_column

    actions defaults: false do |resource|
      title = resource.is_displayable ? 'Enabled' : 'Disabled'
      klass = resource.is_displayable ? 'yes' : 'no'
      link_to toggle_display_admin_instagram_medium_path(resource), method: :put do 
        content_tag(:span, title, class: "status_tag #{klass}")
      end
    end

    # column :is_displayable
    column :thumbnail do |instagram_media|
      # image_tag(instagram_media.thumbnail_image_url)
      image_tag(instagram_media.standard_resolution_image_url)
      
    end
    # column :user_full_name do |instagram_media|
    #   instagram_media.instagram_user.full_name
    # end
    column :username do |instagram_media|
      instagram_media.instagram_user.username
    end

    # column :tags
    # column :instagram_id
    # column :likes_count
    # column :comments_count
    # column :users_in_photo_count
    # column :caption_text


    #  column :location do |instagram_media|
    #   instagram_media.location[:name][:s]
    # end

    # column :created_at
    # column :updated_at
    actions
  end

end
