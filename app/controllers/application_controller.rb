class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :true_user, :impersonating?


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

  def impersonating?
    session[:impersonated_user_id].present?
  end

  def true_user
    if session[:admin_id]
      @true_user = User.find_by(id: session[:admin_id])
    else
      @true_user = current_user
    end
  end


  def current_user
    if session[:impersonated_user_id]
      @current_user = User.find_by(id: session[:impersonated_user_id])
    else
      super
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login ])

    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :name , :email, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :name ])
  end
end
