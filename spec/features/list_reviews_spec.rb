require 'spec_helper'

describe "Listing Reviews" do
  it "shows a list of all the reviews that belong to a movie" do
    movie1 = Movie.create(movie_attributes(title: "Iron Man"))
    review1 = movie1.reviews.create(review_attributes(full_name: "Roger Ebert"))
    review2 = movie1.reviews.create(review_attributes(full_name: "Gene Siskel"))


    movie2 = Movie.create(movie_attributes(title: "Superman"))
    review3 = movie2.reviews.create(review_attributes(full_name: "Peter Travers"))

    visit movie_reviews_url(movie1)

    expect(page).to have_text(review1.full_name)
    expect(page).to have_text(review2.full_name)
    expect(page).not_to have_text(review3.full_name)
  end
end
