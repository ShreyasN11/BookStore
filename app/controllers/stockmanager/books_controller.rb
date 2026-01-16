class Stockmanager::BooksController < StockmanagerController
    def index
      @books = Book.all.order(created_at: :desc)

      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(@books), filename: "Stock-#{Date.today}.csv" }
      end
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to stockmanager_books_path, notice: "Book created successfully."
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
        redirect_to stockmanager_books_path, notice: "Book updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to stockmanager_books_path, notice: "Book deleted."
    end

    def generate_csv(books)
      csv_data = CSV.generate(headers: true) do |csv|
        csv << [ "Title", "Author", "Description", "Price", "ISBN", "Published Year", "Quantity", "Genre", "Created At" ]
        books.each do |book|
          csv << [ book.title, book.author.name, book.description, book.price, book.isbn, book.published_year, book.quantity, book.genre, book.created_at ]
        end
      end
    end

    def import
      file = params[:file]
      if file.nil?
        return redirect_to stockmanager_books_path, alert: "Please upload a CSV file."
      end

      unless file.content_type == "text/csv"
        return redirect_to stockmanager_books_path, alert: "Invalid file type. Please upload a CSV."
      end

      begin
        CSV.foreach(file.path, headers: true) do |row|
          book = Book.find_or_initialize_by(isbn: row["ISBN"])

          book.update!(title: row["Title"], author_name: row["Author"], description: row["Description"], price: row["Price"], published_year: row["Published Year"], quantity: row["Quantity"], genre: row["Genre"], created_at: Time.current)
        end
        redirect_to stockmanager_books_path, notice: "Books imported/updated successfully."
      rescue => e
        redirect_to stockmanager_books_path, alert: "Error during import: #{e.message}"
      end
    end

    private

    def book_params
      params.require(:book).permit(:title, :author_name, :description, :price, :isbn, :published_year, :quantity, :genre, images: [])
    end
end
