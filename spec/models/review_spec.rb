require 'spec_helper'

describe Review do

  it "is created with valid attributes" do
    review = Review.create!(review_attributes())

    expect(review.valid?).to be_true
  end

  it "belongs to a movie" do
    movie = Movie.create!(movie_attributes())
    review = movie.reviews.new(review_attributes())

    expect(review.movie).to eq(movie)
  end

  it "accepts a review with a full name" do
    review = Review.create!(review_attributes())

    expect(review.valid?).to be_true
    expect(review.errors[:full_name].any?).to be_false
  end

  it "rejects a review without a full name" do
    review = Review.create(review_attributes(full_name: nil))

    expect(review.valid?).to be_false
    expect(review.errors[:full_name].any?).to be_true
  end

  it "accepts a comment with more then four characters" do
    review = Review.create(review_attributes())

    expect(review.valid?).to be_true
    expect(review.errors[:comment].any?).to be_false
  end

  it "rejects a comment with less then three characters " do
    review = Review.create(review_attributes(comment: "a" * 2))

    expect(review.valid?).to be_false
    expect(review.errors[:comment].any?).to be_true
  end

  it "accepts star values of 1 through 5" do
    stars = [1, 2, 3, 4, 5]
    stars.each do |star|
      review = Review.new(stars: star)

      expect(review.valid?).to be_false
      expect(review.errors[:stars].any?).to be_false
    end
  end

  it "rejects invalid star values" do
    stars = [-1, 0, 6]
    stars.each do |star|
      review = Review.new(stars: star)

      expect(review.valid?).to be_false
      expect(review.errors[:stars].any?).to be_true
      expect(review.errors[:stars].first).to eq("must be between 1 and 5")
    end
  end
end
