Rails.application.routes.draw do

  root 'hashtag#show', id: 'birthrightstories'

  resources :hashtag, only: [:show]

end
