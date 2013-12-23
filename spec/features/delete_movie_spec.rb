require "spec_helper"

describe "Deleting a movie" do
  it "removes the movie from the movie website" do
    movie = Movie.create(movie_attributes(total_gross: 318412101))

    visit movie_path(movie)
    expect(page).to have_text("Iron Man")
    expect(Movie.count).to eq (1)

    click_on "Delete"

    expect(current_path).to eq(root_path)
    expect(Movie.count).to eq (0)
  end
end
