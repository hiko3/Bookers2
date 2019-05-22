class UsersController < ApplicationController
before_action :authenticate_user!
  def show
  	@book = Book.new
  	@user = User.find(params[:id])
  	# @books = @user.books
  	@books = Book.all
  end

  def index
  	@users = User.all
    @user = current_user
    @book = Book.new

  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.save(user_params)
  	redirect_to user_path(@user)
  end

  def edit
  	@user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "successfully update!"
  	redirect_to user_path(@user)

    else
      @book = Book.new
      @books = Book.all
      flash[:notice] = "update error!"
      render :show
    end
  end


  private

  def user_params
  	params.require(:user).permit(:name,:profile_image,:introduction)
  end
end
