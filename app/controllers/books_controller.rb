class BooksController < ApplicationController
	before_action :correct_user, only: [:edit,:update]
	before_action :authenticate_user!
	def index
		@books = Book.all
		@user = User.find(current_user.id)
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
		@new_book = Book.new

	end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		# p @book
		if @book.save
			flash[:notice] = "post successfully!"
			redirect_to book_path(@book)

		else @books = Book.all
			 @user = User.find(current_user.id)
			 flash[:notice] = "post error"
			 render :index
		end

	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "update successfully!"
			redirect_to book_path(@book)

		else flash[:notice] = "update error"
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end


private

	def correct_user
		book = Book.find(params[:id])
		user = book.user
		if current_user != user
		  flash[:notice]= "authority error!"
		  redirect_to books_path
		end
	end

	def book_params
		params.require(:book).permit(:title,:body)
	end


end
