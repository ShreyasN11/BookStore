class Admin::ImpersonationsController < AdminController
      def create
        if params[:user_id].blank?
          return redirect_to admin_users_path, alert: "Please select a user."
        end

        user = User.find(params[:user_id])

        if !current_user.superadmin? && !user.customer?
          redirect_to admin_users_path, alert: "You can only impersonate customers."
          return
        end

        session[:admin_id] = current_user.id
        session[:impersonated_user_id] = user.id

        redirect_to root_path, notice: "Now impersonating #{user.email}"
      end

      def destroy
        session.delete(:impersonated_user_id)
        session.delete(:admin_id)
        redirect_to admin_users_path, status: :see_other, notice: "Stopped impersonating."
      end
end
