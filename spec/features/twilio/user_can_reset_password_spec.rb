require 'rails_helper'

feature "User Can Reset Password" do
  it "resets their password" do
    visit "/"
    click_on "Forgot My Password"

    expect(current_path).to eq("/password-reset")

    fill_in 'Email', with: "josh@example.com"
    click_on "Submit"

    expect(current_path).to eq("/password-confirmation")

    expect(page).to have_content "Password Reset Instructions"
    expect(page).to have_content "Enter Confirmation Code"

    fill_in 'Password', with: "password"
    fill_in 'Password Confirmation', with: "password"
    click_on "Submit"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content "Logged In"

    click_on "Logout"
    click_on "Login"

    fill_in 'Email', with: "josh@example.com"
    fill_in 'Password', with: 'password'

    expect(current_path).to eq("/dashboard")
  end

  it "old password does not work" do
  end
end
# As a guest user
# When I visit "/login"
# And I click "Forgot my Password"
# Then I should be on '/password-reset'
# When I fill in Email with "josh@example.com"
# And I click Submit
# Then I should be redirected to "/password-confirmation"
# And I should see instructions to enter my confirmation code
# And I should have received a text message with a confirmation code
# When I enter the confirmation code
# And I fill in Password with password
# And I fill in Password Confirmation with password
# And I click "Submit"
# Then I should be redirected to "/dashboard"
# And I should be logged in
# And my old password should no longer work for logging in
# And my new password should work after logging out and logging back in