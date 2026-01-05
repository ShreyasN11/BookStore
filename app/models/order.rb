class Order < ApplicationRecord
  enum :status, { completed: 0, pending: 1 }

  belongs_to :user
  has_many :order_items, dependent: :destroy
end
