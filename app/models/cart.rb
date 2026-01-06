class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :books, through: :cart_items

  def total_price
    cart_items.sum { |item| item.book.price * item.quantity }
  end
end
