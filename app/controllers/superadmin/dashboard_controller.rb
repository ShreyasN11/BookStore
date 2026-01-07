class Superadmin::DashboardController < SuperadminController
    def index
        @total_users = User.count
        @total_orders = Order.count

        @users = User.all.order(created_at: :desc)
        @books = Book.all.order(created_at: :desc).limit(10)
        @orders = Order.includes(:user).all.order(created_at: :desc).limit(10)
    end
  
    def update_role
        @user = User.find(params[:id])
        if @user.update(role: params[:role])
        redirect_to superadmin_root_path, notice: "Role for #{@user.email} updated to #{params[:role]}."
        else
          redirect_to superadmin_root_path, alert: "Unable to update role."
        end
    end
end