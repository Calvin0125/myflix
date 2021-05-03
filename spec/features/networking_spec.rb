feature "Social Networking" do
  background do
    @calvin = User.create(full_name: 'Calvin Conley', email: 'calvin@conley.com', password: 'password')
    @blake = User.create(full_name: 'Blake Smith', email: 'blake@smith.com', password: 'password')
    sci_fi = Category.create(name: 'Sci-fi')
    @star_wars = Video.create(title: 'Star Wars', description: 'Battles in space', category_id: sci_fi.id)
    @star_trek = Video.create(title: 'Star Trek', description: 'Adventures in space', category_id: sci_fi.id)
    @interstellar = Video.create(title: 'Interstellar', description: 'Space voyages', category_id: sci_fi.id)
    Fabricate(:queue_item, user_id: @blake.id, video_id: @star_wars.id)
    Fabricate(:review, video_id: @star_wars.id, user_id: @blake.id)
    visit '/login'
    fill_in 'Email', with: 'calvin@conley.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end

  scenario "user follows and unfollows another user" do
    click_link "video#{@star_wars.id}"
    click_link "Blake Smith"
    click_link "Follow"
    click_link "People"
    expect(page).to have_content "Blake Smith"
    click_link "x"
    expect(page).to have_content "You have unfollowed Blake Smith."
    visit '/people'
    expect(page).not_to have_content "Blake Smith"
  end
end