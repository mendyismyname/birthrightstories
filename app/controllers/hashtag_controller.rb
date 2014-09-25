class HashtagController < ApplicationController

  respond_to :json, :html, :xml

  expose(:hashtag)
  expose(:current_page)          { params[:page] }
  expose(:instagram_medias)      { hashtag.instagram_medias
                                          .displayable
                                          .page(current_page).per(24)
                                          .includes(:instagram_user) }
  expose(:instagram_medias_rand) { instagram_medias.shuffle }
  expose(:current_story_count)   { '400,000' }
  # expose(:autoexpanded_media) { params[:autoexpand] }

  expose(:other_available_locales) { I18n.available_locales.find_all {|l| l != I18n.locale } }

  def show
    respond_with instagram_medias
  end 

  # private

  # def instagram_medias_hack
  #   InstagramMedia.displayable.order_by_rand.page(current_page).per(60).includes(:instagram_user)
  # end

end
