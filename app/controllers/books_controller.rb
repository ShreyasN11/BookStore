class BooksController < ApplicationController
    def index
        if params[:query].present?
          @books = Book.where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
        else
          @books = Book.all
        end
    end

    def show
        @book = Book.find(params[:id])
    end
end
