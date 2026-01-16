class Book < ApplicationRecord
    has_many_attached :images
    has_many :order_items
    belongs_to :author

    attr_accessor :author_name
    before_validation :assign_author_by_name

    def assign_author_by_name
        if author_name.present?
          self.author = Author.find_or_create_by(name: author_name.strip)
        end
    end


    validates :title, :author, :price, presence: true
end
