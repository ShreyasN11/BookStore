require 'csv'
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user!, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders # Assumes User has_many :orders

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@orders), filename: "orders-#{Date.today}.csv" }
    end    
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def generate_csv(orders)
    CSV.generate(headers: true) do |csv|
      csv << ["Order ID", "Status", "Date", "Total Price"]
      orders.each do |order|
        csv << [order.id, order.status, order.created_at, order.total_price]
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def authorize_user!
    unless current_user.id == @user.id
      redirect_to root_path, alert: "You are not authorized to view this profile."
    end
  end
end