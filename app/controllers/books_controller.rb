class BooksController < ApplicationController
    def index
        if params[:query].present?
          @books = Book.joins(:author).where("books.title ILIKE :q OR authors.name ILIKE :q OR books.genre ILIKE :q", q: "%#{params[:query]}%")
        else
          @books = Book.all
        end
    end

    def show
        @book = Book.find(params[:id])
    end
end
