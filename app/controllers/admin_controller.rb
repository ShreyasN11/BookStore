class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :restrict_impersonator_access!

    private

    def authorize_admin!
      unless true_user&.admin? || true_user&.superadmin?
        redirect_to root_path, alert: "Access denied. Admins only."
      end
    end

    def restrict_impersonator_access!
      if impersonating? && controller_name != "impersonations"
        redirect_to root_path, alert: "Access denied"
      end
    end
end
