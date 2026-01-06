class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  def subtotal
    book.price * quantity
  end
end
