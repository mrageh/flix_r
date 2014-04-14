require 'spec_helper'

feature 'Viewing a users profile page' do
  scenario 'shows the users details' do
    user = User.create!(user_attributes)

    sign_in(user.email, 'secret')

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end

  scenario 'lists all their favourtie movies' do
    user = User.create!(user_attributes)
    movie1 = Movie.create!(movie_attributes(title: 'one piece'))
    movie2 = Movie.create!(movie_attributes(title: 'luffy'))
    Favourite.create!(favourite_attributes(user_id: user.id, movie_id: movie1.id))
    Favourite.create!(favourite_attributes(user_id: user.id, movie_id: movie2.id))

    sign_in(user.email, 'secret')

    expect(page).to have_text('Favourite Movies')
    expect(page).to have_link('one piece')
    expect(page).to have_link('luffy')
  end
end
