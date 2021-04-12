require 'rails_helper'

describe Video do
  before(:each) do 
    @category = Category.create(name: "Sci-fi")
    @video = Video.create(title: "Star Wars", 
                       description: "Battles in space", 
                       large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+Wars", 
                       small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+Wars", 
                       category_id: Category.first.id)
  end

  it 'should save' do
    expect(Video.first).to eq(@video)
  end

  it 'should belong to Sci-fi category' do
    expect(@video.category).to eq(@category)
  end
end