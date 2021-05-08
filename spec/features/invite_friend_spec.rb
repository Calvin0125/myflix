feature "Invite a friend" do
  background do
    User.create(full_name: 'Calvin Conley', email: 'calvin@conley.com', password: 'password')
    @bob = Fabricate(:user)
    visit '/login'
    fill_in 'Email', with: 'calvin@conley.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "User invites a friend that is already signed up" do
    click_link "People"
    click_link "Invite a friend"
    fill_in "Friend's Name", with: "#{@bob.full_name}"
    fill_in "Friend's Email Address", with: "#{@bob.email}"
    fill_in "Invitation Message", with: "Please sign up for MyFlix!"
    click_button "Send Invitation"
    expect(page).to have_content "This user has already joined MyFlix."
  end

  scenario "User invites a friend" do
    click_link "People"
    click_link "Invite a friend"
    fill_in "Friend's Name", with: "Daffy Duck"
    fill_in "Friend's Email Address", with: "daffy@duck.com"
    fill_in "Invitation Message", with: "Please sign up for MyFlix!"
    click_button "Send Invitation"
    open_email "daffy@duck.com"
    Capybara.current_session.driver.browser.clear_cookies
    current_email.click_link
    expect(find_field("Email").value).to eq("daffy@duck.com")
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Daffy Duck"
    click_button "Sign Up"
    fill_in "Email", with: "daffy@duck.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    click_link "People"
    expect(page).to have_content("Calvin Conley")
    find("a.dropdown-toggle").click
    click_link "Sign Out"
    click_link "Sign In"
    fill_in "Email", with: "calvin@conley.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    click_link "People"
    expect(page).to have_content("Daffy Duck")
  end
end