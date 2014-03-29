require 'spec_helper'

describe User do
  before do
    @user = User.new(
      name: 'Adam',
      email: 'Adam@exameple.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  context 'email' do
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

  context 'name' do
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
end
