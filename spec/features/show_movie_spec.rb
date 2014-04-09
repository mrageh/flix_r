require 'spec_helper'
feature 'Viewing an individual movie' do
  scenario 'shows the movies details' do
    movie = Movie.create(movie_attributes(total_gross: 318412101))

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text('$318,412,101.00')
    expect(page).to have_text(movie.released_on)
    expect(page).to have_selector("img[src$='#{movie.image_file_name}']")
  end

  scenario 'shows the total gross if the total gross exceeds $50M' do
    movie = Movie.create(movie_attributes(total_gross: 318412101))

    visit movie_path(movie)

    expect(page).to have_text('$318,412,101.00')
  end

  scenario 'shows Flop! if the total gross is less than $50M' do
    movie = Movie.create(movie_attributes(total_gross: 31841))

    visit movie_path(movie)

    expect(page).to have_text('Flop!')
  end
end
