require 'spec_helper'

describe "Can create movie" do
  it "user can create a new movie" do
    visit root_path
    click_on "Add New Movie"

    expect(current_path).to eq(new_movie_path)

    fill_in "Title", with: "Iron Man 3"
    fill_in "Description", with: "Trilogy finale who is going to win"
    fill_in "Total gross", with: 45000000
    fill_in "Rating", with: "PG-13"
    fill_in "Director", with: "Jon Favreau"
    fill_in "Duration", with: "130 minutes"
    fill_in "Cast", with: "Robert Downey Jr, Terrence Howard, Jeff Bridges"
    fill_in "Image file name", with: "ironman.jpg"

    select (Time.now.year - 1).to_s, from: "movie[released_on(1i)]"
    select ("June").to_s, from: "movie[released_on(2i)]"
    select (Time.now.day).to_s, from: "movie[released_on(3i)]"
    click_on "Create Movie"

    expect(Movie.all.count).to eq(1)
    expect(page).to have_text("Movie successfully created!")
    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text("Iron Man 3")
  end

  it "has a default image if none is specified" do
    visit new_movie_path

    fill_in "Title", with: "Iron Man 3"
    fill_in "Description", with: "Trilogy finale who is going to win"
    fill_in "Total gross", with: 45000000
    fill_in "Rating", with: "PG-13"
    fill_in "Director", with: "Jon Favreau"
    fill_in "Duration", with: "130 minutes"
    fill_in "Cast", with: "Robert Downey Jr, Terrence Howard, Jeff Bridges"
    select (Time.now.year - 1).to_s, from: "movie[released_on(1i)]"
    click_on "Create Movie"

    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_selector("img[src$='#{Movie.last.image_file_name}']")
  end
end
