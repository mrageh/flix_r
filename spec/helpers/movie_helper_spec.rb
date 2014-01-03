require 'spec_helper'

describe MoviesHelper do
  describe "helper the movie" do
    it "formats the total gross" do
      movie = Movie.create(movie_attributes)

      expect(helper.format_total_gross(movie)).to eq("$318,412,101.00")
    end

    it "returns flop when the movie is a flop" do
      movie = Movie.create(movie_attributes(total_gross: 0))

      expect(helper.format_total_gross(movie)).to eq("Flop!")
    end

    it "movie has specified image" do
      movie = Movie.create(movie_attributes)

      expect(helper.image_for(movie)).to include("ironman.jpg")
    end

    it "movie has default image if none is specified" do
      movie = Movie.create(movie_attributes(image_file_name: nil))

      expect(helper.image_for(movie)).to include("placeholder.png")
    end
  end
end
