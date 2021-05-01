feature "Signing in" do
  background do
    User.create(full_name: 'Calvin Conley', password: 'seekrit', email: 'calvin@conley.com')
  end

  scenario "Signing in with valid input" do
    visit '/login'
    fill_in 'Email', with: 'calvin@conley.com'
    fill_in 'Password', with: 'seekrit'
    click_button 'Sign in'
    expect(page).to have_content 'You have been logged in.'
  end

  scenario "Signing in with invalid input" do
    visit '/login'
    fill_in 'Email', with: 'wrong_email@not_an_email.com'
    fill_in 'Password', with: 'wrong_password'
    click_button 'Sign in'
    expect(page).to have_content "Invalid username or password."
  end
end