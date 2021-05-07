feature "reset_password" do
  background do
    @user = Fabricate(:user, password: 'oldpassword')
  end

  scenario "user resets password" do
    visit '/login'
    click_on "Forgot password"
    fill_in "Email", with: @user.email
    click_on "Send Email"
    open_email @user.email
    current_email.click_link 'Reset Password'
    fill_in "Password", with: 'newpassword'
    click_on "Reset Password"
    current_email.click_link 'Reset Password'
    expect(page).not_to have_content "Reset Password"
    visit '/login'
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'newpassword'
    click_on "Sign in"
    expect(page).to have_content("You have been logged in.")
  end

end