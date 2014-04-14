require 'spec_helper'

feature 'Creating a new review' do
  before do
    @user = User.create!(user_attributes())
    sign_in(@user.email, 'secret')
  end

  scenario 'saves the review' do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    click_link 'Write Review'

    expect(current_path).to eq(new_movie_review_path(movie))

    select 5, from: 'Stars'
    fill_in 'Comment', with: 'I laughed, I cried, I spilled my popcorn!'

    click_button 'Post Review'

    expect(current_path).to eq(movie_reviews_path(movie))
    expect(page).to have_text("Thanks for your review #{@user.name}!")
    expect(page).to have_text(@user.name)
  end

  scenario 'does not save the review if its invalid' do
    movie = Movie.create(movie_attributes)

    visit new_movie_review_url(movie)

    expect {
      click_button 'Post Review'
    }.not_to change(Review, :count)

    expect(page).to have_text('error')
  end
end
