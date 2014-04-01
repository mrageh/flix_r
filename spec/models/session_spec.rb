require 'spec_helper'

describe Session do
  describe '.new' do
    it 'can be created without options' do
      session = Session.new

      expect(session).to be_valid
    end

    it 'can be created with options' do
      session = Session.new(email: 'test@example.com', password: 'password')

      expect(session.email).to eq 'test@example.com' 
      expect(session.password).to eq 'password' 
    end
  end

  describe '#user' do
    context 'with a valid email address and password' do
      it 'returns a user' do
        user = User.create!(user_attributes(
          name: "test", 
          email: "test@example.com", 
          password: 'password', 
          password_confirmation: 'password'
        ))
        session = Session.new(email: 'test@example.com', password: 'password')

        expect(session.user).to eq user
      end
    end

    context 'with a valid email and a bad password' do
      it 'returns false' do
        user = User.create!(user_attributes(
          name: "test", 
          email: "test@example.com", 
          password: 'password', 
          password_confirmation: 'password'
        ))
        session = Session.new(email: 'test@example.com', password: 'badpassword')

        expect(session.user).to be_false
        expect(session.user).not_to eq user
      end
    end

    context 'with a bad email address' do
      it 'returns nil' do
        user = User.create!(user_attributes(
          name: "test", 
          email: "test@example.com", 
          password: 'password', 
          password_confirmation: 'password'
        ))
        session = Session.new(email: 'bademail', password: 'password')

        expect(session.user).to be_nil 
        expect(session.user).not_to eq user
      end
    end
  end

end
