require "spec_helper"

describe "A movie" do

  it "has many reviews" do
    movie = Movie.create!(movie_attributes())
    review1 = Review.create!(review_attributes(movie_id: movie.id))
    review2 = movie.reviews.create!(review_attributes())

    expect(movie.reviews).to include(review1)
    expect(movie.reviews).to include(review2)
  end

  it "associated reviews are deleted" do
    movie = Movie.create!(movie_attributes())
    review1 = Review.create!(review_attributes(movie_id: movie.id))
    review2 = movie.reviews.create!(review_attributes())

    expect{movie.destroy}.to change(Review, :count).by(-2)
  end

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

  it "shows the average number of review stars" do
    movie = Movie.create(movie_attributes)
    movie.reviews.create(review_attributes(stars: 5))
    movie.reviews.create(review_attributes(stars: 2))
    movie.reviews.create(review_attributes(stars: 2))

    expect(movie.average_stars).to eq(3)
  end

  it "returns if it has no reviews" do
    movie = Movie.create(movie_attributes)
    expect(movie.any_reviews?).to be_false
  end

  it "shows cult classic movies" do
    movie = Movie.create(movie_attributes)
    50.times { movie.reviews.create(review_attributes(stars: 4)) }

    expect(movie.cult_classic?).to be_true
  end

  context '#favourites' do
    it 'has many' do
      movie = Movie.create!(movie_attributes)
      favourite1 = Favourite.create!(favourite_attributes(movie_id: movie.id))
      favourite2 = Favourite.create!(favourite_attributes(movie_id: movie.id))

      expect(movie.favourites).to include favourite1
      expect(movie.favourites).to include favourite2
    end
  end

  context '#fans' do
    it 'has many' do
      movie = Movie.create!(movie_attributes)
      user1 = User.create!(user_attributes(
        name: 'Larry',
        email: 'larry@example.com',
      ))
      user2 = User.create!(user_attributes(
        name: 'Moe',
        email: 'moe@example.com'
      ))
      favourite1 = Favourite.create!(favourite_attributes(movie_id: movie.id, user_id: user1.id))
      favourite2 = Favourite.create!(favourite_attributes(movie_id: movie.id, user_id: user2.id))

      expect(movie.fans).to include user1
      expect(movie.fans).to include user2
    end
  end

end
