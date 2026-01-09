class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?


  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.superadmin?
      superadmin_root_path
    elsif resource.stockmanager?
      stockmanager_root_path
    else
      root_path
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login ])

    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :name ])
  end
end
