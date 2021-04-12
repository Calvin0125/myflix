require 'rails_helper'
describe Category do
  before(:each) do
  @category = Category.create(name: "Sci-fi")
  @video1 = Video.create(title: "Star Wars", 
                         description: "Battles in space", 
                         large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+...", 
                         small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+...", 
                         category_id: Category.first.id)
  @video2 = Video.create(title: "Star Trek",
                         description: "Space Voyages",
                         large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Trek", 
                         small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Trek",
                         category_id: Category.first.id)
  end

  it "should save" do
    expect(Category.first).to eq(@category)
  end

  it "can have many videos" do
    expect([Category.first.videos[0], Category.first.videos[1]]).to eq([@video1, @video2])
  end
end