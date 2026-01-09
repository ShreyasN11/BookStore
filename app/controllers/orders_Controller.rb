class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart

    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    ActiveRecord::Base.transaction do
      @order = current_user.orders.create!(
        total_price: @cart.total_price,
        status: :pending
      )

      @cart.cart_items.each do |item|
        @order.order_items.create!(
          book_id: item.book_id,
          quantity: item.quantity,
          price: item.book.price
        )
      end

      @cart.cart_items.destroy_all
      UserMailer.order_receipt(@order).deliver_later
    end


    redirect_to order_path(@order), notice: "Your order has been placed successfully!"
    rescue ActiveRecord::RecordInvalid
      redirect_to cart_path, alert: "There was an error processing your order."
  end

  def buy_now
    @book = Book.find(params[:book_id])
    ActiveRecord::Base.transaction do
      @order = current_user.orders.create!(
        total_price: @book.price,
        status: :pending
      )
      @order.order_items.create!(
        book_id: @book.id,
        quantity: 1,
        price: @book.price
      )
    end
    redirect_to order_path(@order), notice: "Thank you for your purchase! Your book is ready."
    rescue ActiveRecord::RecordInvalid
      redirect_to book_path(@book), alert: "We couldn't process your purchase. Please try again."
    end


  def show
    @order = current_user.orders.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to user_path(current_user), alert: "Order not found or unauthorized."
  end
end
