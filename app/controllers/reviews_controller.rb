class ReviewsController < ApplicationController

  def index
    @movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews.all
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.create(review_params)
    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end
  private

  def review_params
    params.require(:review).permit(:full_name, :stars, :comment)
  end
end
