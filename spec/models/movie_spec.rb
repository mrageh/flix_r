require "spec_helper"

describe "A movie" do
  it "is a flop if the total gross is less than $50M" do
    movie = Movie.new(total_gross: 12101)

    expect(movie.flop?).to eq(true)
  end

  it "is not a flop if the total gross is more then $50M" do
    movie = Movie.new(total_gross: 318412101)

    expect(movie.flop?).to eq(false)
  end

  it "is a flop if no total gross is specified" do
    movie = Movie.new(total_gross: nil)

    expect(movie.flop?).to eq(true)
  end

  it "can not  be seen if it has not been released" do
    movie = Movie.create(movie_attributes(released_on: 2.months.from_now))

    expect(Movie.released).not_to include(movie)
  end

  it "can be seen if it has been released" do
    movie = Movie.create(movie_attributes)

    expect(Movie.released).to include(movie)
  end

  it "returns released movies ordered with the most recent release" do
    movie1 = Movie.create(movie_attributes(released_on: 3.months.ago))
    movie2 = Movie.create(movie_attributes(released_on: 2.months.ago))
    movie3 = Movie.create(movie_attributes(released_on: 1.months.ago))

    expect(Movie.released).to eq([movie3, movie2, movie1])
  end
end
