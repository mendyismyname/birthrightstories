class HashtagController < ApplicationController

  respond_to :json, :html, :xml

  expose(:results)
  expose(:hashtag)
  expose(:current_page)                  { params[:page] }
  expose(:autoexpand_id)                 { params[:autoexpand_id] || false }
  expose(:instagram_medias)              { hashtag.instagram_medias
                                                  .displayable
                                                  .page(current_page).per(20)
                                                  .includes(:instagram_user) }
  expose(:selected)                      { autoexpaned_selection }
  expose(:current_story_count)           { '400,000' }

  expose(:other_available_locales) { I18n.available_locales.find_all {|l| l != I18n.locale } }

  def show
    respond_with selected, instagram_medias
  end 

  # def instagram_medias_hack
  #   InstagramMedia.displayable.order_by_rand.page(current_page).per(60).includes(:instagram_user)
  # end

  def autoexpaned_selection
    if autoexpand_id && (current_page.blank? || current_page == 1) && !instagram_medias.pluck(:id).include?(autoexpand_id.try(:to_i))
      [InstagramMedia.find(autoexpand_id)].compact
    else
      []
    end
  end

end
