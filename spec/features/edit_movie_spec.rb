require "spec_helper"

describe "Editing a movie" do
  it "allows the new details to be updated" do
    movie = Movie.create(movie_attributes())

    visit edit_movie_path(movie)

    expect(current_path).to eq(edit_movie_path(movie))
    expect(page).to have_content("Editing #{movie.title}")
    fill_in "Title", with: "Iron Man 2"
    fill_in "Rating", with: "15"
    fill_in "Total gross", with: 4500000
    fill_in "Description", with: "Epic sequel to Iron Man"
    select "2013", from: "movie[released_on(1i)]"
    select "July", from: "movie[released_on(2i)]"
    select "11", from: "movie[released_on(3i)]"

    click_button "Update Movie"

    expect(current_path).to eq(movie_path(movie))
  end
end

