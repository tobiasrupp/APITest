class FinishedBooksController < ApplicationController

  def index
    books = Book.finished
    if rating = params[:rating]
      books = books.where(rating: rating)
    end
    respond_to do |format|
      format.xml { render xml: books, status: 200 }
      format.json { render json: books, status: 200 }
    end
  end
end
