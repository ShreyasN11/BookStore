class SuperadminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin!

  private

  def authorize_super_admin!
    unless current_user.superadmin?
      redirect_to root_path, alert: "Access denied. Restricted to Super Admins."
    end
  end

end    