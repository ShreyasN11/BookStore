class OrdersController < ApplicationController
    before_action :authenticate_user!

    def show
      @order = current_user.orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to user_path(current_user), alert: "Order not found or unauthorized."
    end
end
