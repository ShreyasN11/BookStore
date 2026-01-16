class Admin::AuthorsController < AdminController
    before_action :set_author, only: [ :show, :edit, :update, :destroy ]

    def index
      @authors = Author.all.order(name: :asc)
    end


    def new
      @author = Author.new
    end

    def create
      @author = Author.new(author_params)
      if @author.save
        redirect_to admin_authors_path, notice: "Author profile created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def show
    end


    def update
      if @author.update(author_params)
        redirect_to admin_authors_path, notice: "Author updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @author.destroy
      redirect_to admin_authors_path, notice: "Author deleted."
    end

    private

    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name, :bio, images: [])
    end
end
