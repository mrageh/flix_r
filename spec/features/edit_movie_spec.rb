require 'spec_helper'

feature 'Editing a movie' do
  scenario 'allows the new details to be updated' do
    movie = Movie.create(movie_attributes())

    visit edit_movie_path(movie)

    expect(current_path).to eq(edit_movie_path(movie))
    expect(page).to have_content("Editing #{movie.title}")

    fill_in 'Title', with: 'Iron Man 2'
    fill_in 'Total gross', with: 4500000
    fill_in 'Description', with: 'Epic sequel to Iron Man the most thrilling'
    fill_in 'Rating', with: 'PG-13'
    fill_in 'Director', with: 'Jon Favreau'
    fill_in 'Duration', with: '130 minutes'
    fill_in 'Cast', with: 'Robert Downey Jr, Terrence Howard, Jeff Bridges'
    fill_in 'Image file name', with: 'ironman.jpg'
    select (Time.now.year - 1).to_s, from: 'movie[released_on(1i)]'
    select 'July', from: 'movie[released_on(2i)]'
    select '11', from: 'movie[released_on(3i)]'
    click_button 'Update Movie'


    expect(current_path).to eq(movie_path(movie))
    expect(page).to have_text('Movie successfully updated!')
    expect(page).to have_content('Iron Man 2')
    expect(page).to have_content('PG-13')
    expect(page).to have_content('Epic sequel to Iron Man')
  end
end

