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
end
