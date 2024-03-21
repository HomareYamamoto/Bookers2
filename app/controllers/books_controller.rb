class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update, :destroy]


  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end


  def index
    @user=current_user
    @book=Book.new
    @books=Book.all
  end



  def show
    @book=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)
    else
       render :edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end



private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    @user=@book.user
    unless @user == current_user
      redirect_to books_path
    end
  end

end