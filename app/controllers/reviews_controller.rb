class ReviewsController < ApplicationController
  before_action :require_signin

  def index
    @movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.create(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Thanks for your review #{@review.user.name}!"
    else
      render :new
    end
  end
  private

  def review_params
    params.require(:review).permit(:full_name, :stars, :comment)
  end
end
