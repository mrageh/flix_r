require 'spec_helper'

feature 'Deleting a movie' do
  scenario 'removes the movie from the movie website' do
    User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    ))
    sign_in('adam@example.com', 'password')
    movie = Movie.create(movie_attributes(total_gross: 318412101))

    visit movie_path(movie)
    expect(page).to have_text('Iron Man')
    expect(Movie.count).to eq (1)

    click_on 'Delete'

    expect(current_path).to eq(movies_path)
    expect(page).to have_text('Movie successfully deleted!')
    expect(Movie.count).to eq (0)
  end
end
