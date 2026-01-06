class BooksController < ApplicationController
    def index
        if params[:query].present?
          @books = Book.where("title ILIKE ? OR author ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
        else
          @books = Book.all
        end
      
        respond_to do |format|
          format.html 
          format.turbo_stream 
        end
    end

    def show
        @book = Book.find(params[:id])
    end
end
