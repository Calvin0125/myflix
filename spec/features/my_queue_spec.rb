feature "My Queue" do
  background do
    User.create(full_name: 'Calvin Conley', email: 'calvin@conley.com', password: 'password')
    sci_fi = Category.create(name: 'Sci-fi')
    @star_wars = Video.create(title: 'Star Wars', description: 'Battles in space', category_id: sci_fi.id)
    @star_trek = Video.create(title: 'Star Trek', description: 'Adventures in space', category_id: sci_fi.id)
    @interstellar = Video.create(title: 'Interstellar', description: 'Space voyages', category_id: sci_fi.id)
    visit '/login'
    fill_in 'Email', with: 'calvin@conley.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "user adds video to my queue" do
    click_link "video#{@star_wars.id}"
    click_link "+ My Queue"
    visit '/my_queue'
    expect(page).to have_content "Star Wars"
    click_link "Star Wars"
    expect(page).to have_content "Battles in space"
    expect(page).not_to have_content "+ My Queue"
  end

  scenario "user reorders videos in queue" do
    click_link "video#{@star_wars.id}"
    click_link "+ My Queue"
    visit '/home'
    
    click_link "video#{@star_trek.id}"
    click_link "+ My Queue"
    visit '/home'

    click_link "video#{@interstellar.id}"
    click_link "+ My Queue"

    click_link "My Queue"
    page.find('tr:nth-child(3) td a[href^="/videos"]').assert_text(:visible, "Interstellar")
    fill_in 'positions[3]', with: '1'
    click_button "+ Update Instant Queue"
    page.find('tr:first-child td a[href^="/videos"]').assert_text(:visible, "Interstellar")
  end
end