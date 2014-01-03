require 'spec_helper'

describe ReviewsHelper do
  describe "#format_average_stars(movie)" do
    it "formats the stars a movie has" do
      movie = Movie.create(movie_attributes)
      movie.reviews.create(review_attributes)

      expect(helper.format_average_star(movie)).to eq("3.0 stars")
    end

    it "returns no reviews if a movie has none" do
      movie = Movie.create(movie_attributes)

      expect(helper.format_average_star(movie)).to eq("<p>No Reviews</p>")
    end
  end
end
