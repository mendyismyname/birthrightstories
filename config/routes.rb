Rails.application.routes.draw do

  root 'hashtag#show', id: 'birthrightstories'

  scope "/:locale" do
    resources :hashtag, only: [:show]
  end

end
