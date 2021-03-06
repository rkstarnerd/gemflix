require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
    user = Fabricate(:user)
    user_signs_in(user)
    page.should have_content user.name
  end

  scenario "with invalid email and password" do
    visit signin_path
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
    page.should have_content "Your username and/or password was incorrect. Please try again."
  end
end

