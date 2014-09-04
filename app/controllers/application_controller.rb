class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  layout 'application'

  before_filter :set_locale
  before_filter :set_locale_from_url

  def permitted_params
    @permitted_params ||= ::PermittedParams.new(params, current_user)
  end

  private

  def set_locale
    I18n.locale = params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

end
