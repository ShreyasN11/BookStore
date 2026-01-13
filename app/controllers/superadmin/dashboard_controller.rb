class Superadmin::DashboardController < SuperadminController
    def index
        @total_users = User.count
        @total_orders = Order.count

        @users = User.all.order(created_at: :desc)
        @books = Book.all.order(created_at: :desc).limit(10)
        @orders = Order.includes(:user).all.order(created_at: :desc).limit(10)

        @sales_by_genre = OrderItem.joins(:book)
        .group("books.genre")
        .sum("order_items.price * order_items.quantity")

        @sales_per_month = Order.group_by_month(:created_at, last: 12).sum(:total_price)


        user_counts = User.group_by_week(:created_at, last: 30).count
        sum = 0
        @user_growth = user_counts.map { |date, count| [ date, sum += count ] }.to_h

        @stock_distribution = Book.group(:genre).count

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "Report_#{Date.today}",
                     template: "superadmin/index",
                     layout: "pdf",
                     disposition: "attachment",
                     print_media_type: true
            end
        end
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
