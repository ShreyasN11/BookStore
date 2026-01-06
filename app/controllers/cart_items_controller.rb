# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart

    def create
      book = Book.find(params[:book_id])
      @cart_item = @cart.cart_items.find_by(book_id: book.id)

      if @cart_item
        @cart_item.increment!(:quantity)
      else
        @cart_item = @cart.cart_items.new(book: book, quantity: 1)
      end

      if @cart_item.save
        redirect_to cart_path, notice: "#{book.title} added to cart."
      else
        redirect_to book_path(book), alert: "Could not add item to cart."
      end
    end

    def update
      @cart_item = @cart.cart_items.find(params[:id])
      if @cart_item.update(cart_item_params)
        redirect_to cart_path, notice: "Cart updated."
      end
    end

    def destroy
      @cart_item = @cart.cart_items.find(params[:id])
      @cart_item.destroy
      redirect_to cart_path, notice: "Item removed from cart."
    end

    private

    def set_cart
      @cart = current_user.cart || current_user.create_cart
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
end
