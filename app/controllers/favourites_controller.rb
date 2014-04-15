class FavouritesController < ApplicationController
  before_action :find_movie

  def create
    @movie.favourites.create(user: current_user)
    redirect_to @movie,notice: 'Thanks for faving!'
  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.destroy
    redirect_to @movie, notice: 'Sorry you unfaved it!'
  end

  private

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end
end
