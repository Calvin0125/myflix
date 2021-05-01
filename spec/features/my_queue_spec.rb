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

  def add_video_to_queue(video)
    visit '/home'
    click_link "video#{video.id}"
    click_link "+ My Queue"
  end

  def assert_position(position, video)
    page.find("tr:nth-child(#{position}) td a[href^='/videos']").assert_text(:visible, video.title)
  end

  def update_position(old_position, new_position)
    fill_in "positions[#{old_position}]", with: "#{new_position}"
  end

  scenario "user adds video to my queue" do
    add_video_to_queue(@star_wars)
    visit '/my_queue'
    expect(page).to have_content "Star Wars"
    click_link "Star Wars"
    expect(page).to have_content "Battles in space"
    expect(page).not_to have_content "+ My Queue"
  end

  scenario "user reorders videos in queue" do
    add_video_to_queue(@star_wars)
    add_video_to_queue(@star_trek)
    add_video_to_queue(@interstellar)

    click_link "My Queue"
    assert_position(3, @interstellar)
    update_position(3, 1)
    click_button "+ Update Instant Queue"
    assert_position(1, @interstellar)
  end
end