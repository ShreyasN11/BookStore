class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    private

    def authorize_admin!
      unless true_user&.admin? || true_user&.superadmin?
        redirect_to root_path, alert: "Access denied. Admins only."
      end
    end
end
