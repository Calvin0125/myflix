require 'rails_helper'

describe Video do
  before(:each) do 
    @sci_fi = Category.create(name: "Sci-fi")
    @star_wars = Video.create(title: "Star Wars", 
                       description: "Battles in space", 
                       large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Wars", 
                       small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Wars", 
                       category_id: Category.first.id)
  end

  it 'should save' do
    expect(Video.first).to eq(@star_wars)
  end

  it 'should belong to Sci-fi category' do
    expect(@star_wars.category).to eq(@sci_fi)
  end
end