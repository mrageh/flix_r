require 'spec_helper'

describe User do
  before do
    @user = User.new(
      name: 'Adam',
      email: 'Adam@exameple.com',
      password: 'password',
      password_confirmation: 'password'
    )
    @movie1 = Movie.create(
      title: 'Iron Man',
      rating: 'PG-13',
      total_gross: 318412101.00,
      description: 'Tony Stark builds an armored suit to fight the throes',
      released_on: '2008-05-02',
      duration: '132 minutes'
    )
    @movie2 = Movie.create(
      title: 'Superman',
      rating: 'PG',
      total_gross: 134218018.00,
      description: 'Clark Kent grows up to be the greatest super-hero',
      released_on: '1978-12-15',
      duration: 'PG-13'
    )

  end

  context '#email' do
    it 'is valid' do
      @user.email = 'adam@exmaple.com'

      expect(@user).to be_valid
    end

    it 'is invalid when blank' do
      @user.email = ''

      expect(@user).not_to be_valid
    end

    it 'is invalid when format is bad' do
      @user.email = 'invalid email'

      expect(@user).not_to be_valid
    end

    it 'is invalid when not unique' do
      @user.email = 'Adam@exameple.com'
      user1 = @user.save
      user2 = User.new(
        name: 'Adam',
        email: 'Adam@exameple.com',
        password: 'secret',
        password_confirmation: 'secret'
      )

      expect(user2).not_to be_valid
    end
  end

  context '#name' do
    it 'is valid when present' do
      @user.name = 'George'
      user = @user

      expect(@user).to be_valid
    end

    it 'is invalid when blank' do
      @user.name = ''
      user = @user

      expect(@user).not_to be_valid
    end
  end

  context '#reviews' do
    it 'has many' do
      @user.save
      user = @user
      review1 = Review.create!(review_attributes(
        user_id: @user.id,
        movie_id: @movie1.id
      ))
      review2 = Review.create!(review_attributes(
        user_id: @user.id,
        movie_id: @movie2.id
      ))

      expect(user.reviews.count).to eq 2
      expect(user.reviews).to include review1
      expect(user.reviews).to include review2
    end
  end
end
