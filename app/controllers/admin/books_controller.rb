# app/controllers/admin/books_controller.rb
class Admin::BooksController < AdminController
    def index
      @books = Book.all.order(created_at: :desc)
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to admin_books_path, notice: "Book created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        redirect_to admin_books_path, notice: "Book updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to admin_books_path, notice: "Book deleted."
    end

    private

    def book_params
      params.require(:book).permit(:title, :author, :description, :price, :isbn, :published_year, images: [])
    end
end
