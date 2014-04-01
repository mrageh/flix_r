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
    expect(page).to have_link(user.name)
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  scenario 'does not sign in the user if the email/password combination is invalid' do
    user = User.create!(user_attributes)

    visit root_url

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'no match'

    click_button 'Sign In'

    expect(page).to have_text('Invalid')
    expect(page).not_to have_link(user.name)
    expect(page).to have_link('Sign In')
    expect(page).to have_link('Sign Up')
  end
end
