ActiveAdmin.register Hashtag do


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
    column :is_active
    column :name
    column 'Total Instagram Images' do |hashtag|
      hashtag.instagram_medias.count
    end
    column :refreshed_at
    column :created_at
    column :updated_at
    actions
  end  

end
