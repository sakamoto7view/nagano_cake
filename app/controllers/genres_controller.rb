class GenresController < ApplicationController
  def index
    @genres = Genres.all
  end
  
  def top
  end
  
end
