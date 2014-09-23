class HashtagController < ApplicationController

  respond_to :json, :html, :xml

  expose(:hashtag)
  expose(:current_page)        { params[:page] }
  expose(:instagram_medias)    { hashtag.instagram_medias.displayable.randomized.page(current_page).per(60) }
  expose(:current_story_count) { '400,000' }
  # expose(:autoexpanded_media) { params[:autoexpand] }

  expose(:other_available_locales) { I18n.available_locales.find_all {|l| l != I18n.locale } }

  def show
    self.instagram_medias = instagram_medias.includes(:instagram_user)
    respond_with instagram_medias
  end 

end
