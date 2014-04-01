require 'spec_helper'

feature 'Signing in' do
  scenario 'signs in the user if the email/password combination is valid' do
    user = User.create!(user_attributes)

    visit root_url

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'

    expect(current_path).to eq(user_path(user))

    expect(page).to have_text("Welcome back, #{user.name}!")
  end

  scenario 'does not sign in the user if the email/password combination is invalid' do
    user = User.create!(user_attributes)

    visit root_url

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'no match'

    click_button 'Sign In'

    expect(page).to have_text('Invalid')
  end
end
