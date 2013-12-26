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

  it "knows if it has a image" do
    movie = Movie.create(movie_attributes(image_file_name: nil))

    expect(Movie.last.image_blank?).to eq(true)
  end

  it "title cannot be empty" do
    movie = Movie.create(movie_attributes(title: nil))

    expect(movie.valid?).to be_false
    expect(movie.errors[:title].any?).to be_true
  end

  it "duration cannot be empty" do
    movie = Movie.create(movie_attributes(duration: nil))

    expect(movie.valid?).to be_false
    expect(movie.errors[:duration].any?).to be_true
  end

  it "release date has to be there" do
    movie = Movie.create(movie_attributes(released_on: nil))

    expect(movie.valid?).to be_false
    expect(movie.errors[:released_on].any?).to be_true
  end

  it "description must be at least 25 characters long" do
    movie = Movie.create(movie_attributes(description: "jffsdakjskjfjka"))

    expect(movie.valid?).to be_false
    expect(movie.errors[:description].any?).to be_true
  end

  it "total gross must be greater than or equal to 0" do
    movie = Movie.create(movie_attributes(total_gross: -1434))

    expect(movie.valid?).to be_false
    expect(movie.errors[:total_gross].any?).to be_true
  end

  it "image file name can only have certain file extensions" do
    movie = Movie.create(movie_attributes(image_file_name: "fdjask.pdf"))

    expect(movie.valid?).to be_false
    expect(movie.errors[:image_file_name].any?).to be_true
  end

  it "the rating must be a universally recognised one for movies" do
    movie = Movie.create(movie_attributes(rating: "GH"))

    expect(movie.valid?).to be_false
    expect(movie.errors[:rating].any?).to be_true
  end
end
