class HashtagController < ApplicationController

  respond_to :json, :html, :xml

  expose(:hashtag)
  expose(:current_page)        { params[:page] }
  expose(:instagram_medias)    { hashtag.instagram_medias.displayable.order_by_rand.page(current_page).per(60) }
  expose(:current_story_count) { '400,000' }
  # expose(:autoexpanded_media) { params[:autoexpand] }

  expose(:other_available_locales) { I18n.available_locales.find_all {|l| l != I18n.locale } }

  def show

    # Hack bc of only a single tag here
    # Should be: 
    # 
    # self.instagram_medias = instagram_medias.includes(:instagram_user)
    self.instagram_medias = instagram_medias_hack
    
    respond_with instagram_medias
  end 

  private

  def instagram_medias_hack
    InstagramMedia.displayable.order_by_rand.page(current_page).per(60).includes(:instagram_user)
  end

end
