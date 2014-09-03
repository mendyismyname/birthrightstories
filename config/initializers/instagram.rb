if defined?(Instagram)

  Instagram.configure do |config|
    config.client_id     = Rails.application.config.environment_app_config.instagram_id
    config.client_secret = Rails.application.config.environment_app_config.instagram_secret
    config.access_token  = Rails.application.config.environment_app_config.instagram_access_token
    # config.scope         = Rails.application.config.environment_app_config.instagram_scope
    # config.redirect_uri  = Rails.application.config.environment_app_config.instagram_redirect_uri
  end

end