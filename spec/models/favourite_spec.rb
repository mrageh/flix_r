require 'spec_helper'

describe Favourite do
  context '#movie' do
    it 'belongs to one' do
      movie = Movie.create!(movie_attributes)
      favourite = Favourite.create!(favourite_attributes(movie_id: movie.id))

      expect(favourite.movie).to eq movie
    end
  end

  context '#user' do
    it 'belongs to one' do
      user = User.create!(user_attributes)
      favourite = Favourite.create!(favourite_attributes(user_id: user.id))

      expect(favourite.user).to eq user
    end
  end
end
