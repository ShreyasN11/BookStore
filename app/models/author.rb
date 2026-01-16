class Author < ApplicationRecord
    has_many :books
    has_many_attached :images
end
