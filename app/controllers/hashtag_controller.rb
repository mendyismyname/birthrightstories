class HashtagController < ApplicationController

  expose(:hashtag)
  expose(:instagram_medias)   { hashtag.instagram_medias }
  # expose(:autoexpanded_media) { params[:autoexpand] }

  def show
  end 

end
