require 'rails_helper'
describe Category do
  before(:each) do
  @sci_fi = Category.create(name: "Sci-fi")
  @star_wars = Video.create(title: "Star Wars", 
                         description: "Battles in space", 
                         large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+...", 
                         small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+...", 
                         category_id: Category.first.id)
  @star_trek = Video.create(title: "Star Trek",
                         description: "Space Voyages",
                         large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Trek", 
                         small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Trek",
                         category_id: Category.first.id)
  end

  it "should save" do
    expect(Category.first).to eq(@sci_fi)
  end

  it "can have many videos" do
    expect(@sci_fi.videos).to include(@star_wars, @star_trek)
  end
end