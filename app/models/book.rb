class Book < ApplicationRecord
    has_many_attached :images
    has_many :order_items
    belongs_to :author


    validates :title, :author, :price, presence: true
end
