class SearchController < ApplicationController

  def search
    if params[:title].present?
        @books = Book.where('title LIKE ?', "%#{params[:title]}%")
    else
        @books = Book.none
    end
  end

end
