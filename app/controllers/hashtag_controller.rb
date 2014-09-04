class HashtagController < ApplicationController

  expose(:hashtag)
  expose(:current_page)       { params[:page] }
  expose(:instagram_medias)   { hashtag.instagram_medias.page(current_page).per(50) }
  # expose(:autoexpanded_media) { params[:autoexpand] }

  def show
  end 

end
