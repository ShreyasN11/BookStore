class Admin::UsersController < AdminController
    before_action :set_user, only: [ :show, :edit, :update, :destroy ]
    before_action :authorize_admin_actions!, only: [ :edit, :update, :destroy ]


    def index
      @users = User.all
    end

    def show
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_admin_actions!
      return if current_user.superadmin?

      unless @user.customer?
        redirect_to admin_users_path, alert: "You are only authorized to manage customer accounts."
      end
    end

    def user_params
      permitted = [ :name, :email ]
      permitted << :role if current_user.superadmin?

      params.require(:user).permit(permitted)
    end
end
