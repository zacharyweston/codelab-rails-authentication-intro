class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :only_allow_signed_in_users, except: [:index, :show]

  # GET /books
  # GET /books.json
  def index
      @books = Book.all
        if params[:title_search].present?
          @books = @books.where('LOWER(title) LIKE LOWER(?)', "%#{params[:title_search]}%")
          # returns all the published posts where the value of
          # `params[:title_search]` case-insensitively matches the
          # title of the post
        end
        if params[:on_shelf].present?
          @books = @books.where('on_shelf = ?', params[:on_shelf] == 'true')
        end
        if params[:min_page_count].present?
          @books = @books.where('page_count >= ?', params[:min_page_count])
        end
        if params[:max_page_count].present?
          @books = @books.where('page_count <= ?', params[:max_page_count])
        end
      @books = @books.order(created_at: :desc)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :page_count, :on_shelf)
    end
end
