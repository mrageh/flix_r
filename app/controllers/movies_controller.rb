class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to movie_path(@movie)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.delete
    redirect_to root_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :duration, :cast, :director, :image_file_name, :description, :rating, :total_gross, :released_on)
  end
end
