require 'spec_helper'

feature 'Listing Reviews' do
  before do
    @user = User.create!(user_attributes())
    sign_in(@user.email, 'secret')
  end

  scenario 'shows a list of all the reviews that belong to a movie' do
    movie1 = Movie.create!(movie_attributes(title: "Iron Man"))
    review1 = movie1.reviews.create!(review_attributes(comment: "Loved", user: @user))
    review2 = movie1.reviews.create!(review_attributes(comment: "Liked", user: @user))


    movie2 = Movie.create!(movie_attributes(title: "Superman"))
    review3 = movie2.reviews.create!(review_attributes(comment: "Boo!", user: @user))

    visit movie_reviews_url(movie1)

    expect(page).to have_text(review1.comment)
    expect(page).to have_text(review2.comment)
    expect(page).not_to have_text(review3.comment)
  end
end
