class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  layout 'application'

  def permitted_params
    @permitted_params ||= ::PermittedParams.new(params, current_user)
  end

end
