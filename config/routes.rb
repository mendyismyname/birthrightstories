Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do

    resources :hashtag, only: [:show]
    # root to: redirect({ eval("Rails.application.routes.url_helpers.hashtag_#{I18n.locale}_path") }), defaults: {id: 'birthrightstories'}

    # root to: 'hashtag#show', defaults: {id: 'birthrightstories'}
  end

  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root
  
  get '/*path', to: redirect("/#{I18n.default_locale}/hashtag/taglit", status: 302), as: :redirected_unfound
end

# ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml', { no_prefixes: true })
