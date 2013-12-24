require "spec_helper"
describe "Viewing an individual movie" do

  it "shows the movie's details" do
    movie = Movie.create(movie_attributes(total_gross: 318412101))

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text("$318,412,101.00")
    expect(page).to have_text(movie.released_on)
    expect(page).to have_selector("img[src$='#{movie.image_file_name}']")
    expect(page).to have_text("Edit")
  end

  it "shows the total gross if the total gross exceeds $50M" do
  movie = Movie.create(movie_attributes(total_gross: 318412101))

  visit movie_path(movie)

  expect(page).to have_text("$318,412,101.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create(movie_attributes(total_gross: 31841))

    visit movie_path(movie)

    expect(page).to have_text("Flop!")
  end
end
