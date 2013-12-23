require 'spec_helper'

describe "Can create movie" do
  it "user can create a new movie" do
    visit root_path
    click_on "Add New Movie"

    expect(current_path).to eq(new_movie_path)

    fill_in "Title", with: "Iron Man 3"
    fill_in "Description", with: "Trilogy finale who is going to win"
    fill_in "Total gross", with: 45000000
    fill_in "Rating", with: "PG-15"
    select (Time.now.year - 1).to_s, from: "movie[released_on(1i)]"
    click_on "Create Movie"

    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text("Iron Man 3")
  end
end
