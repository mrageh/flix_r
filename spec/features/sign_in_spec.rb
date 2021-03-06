require 'spec_helper'

feature 'Signing in' do
  scenario 'signs in the user if the email/password combination is valid' do
    user = User.create!(user_attributes)

    sign_in(user.email, user.password)

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Welcome back, #{user.name}!")
    expect(page).to have_link(user.name)
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  scenario 'does not sign in the user if the email/password combination is invalid' do
    user = User.create!(user_attributes)

    sign_in(user.email, 'invalid')

    expect(page).to have_text('Invalid')
    expect(page).not_to have_link(user.name)
    expect(page).to have_link('Sign In')
    expect(page).to have_link('Sign Up')
  end

  scenario 'redirects to the intended page' do
    user = User.create!(user_attributes)

    visit users_path
    sign_in(user.email, user.password)

    expect(current_path).to eq users_path
  end
end
