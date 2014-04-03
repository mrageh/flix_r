require 'spec_helper'

feature "Viewing a user's profile page" do
  scenario "shows the user's details" do
    user = User.create!(user_attributes)

    sign_in(user.email, 'secret')

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
end
