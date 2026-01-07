class StockmanagerController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_stock_manager!
  
    private
  
    def authorize_stock_manager!
      unless current_user.stockmanager? || current_user.superadmin?
        redirect_to root_path, alert: "Access denied. Restricted to stockmanager."
      end
    end
  
  end    