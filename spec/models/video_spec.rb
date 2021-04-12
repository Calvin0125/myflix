require 'rails_helper'

describe Video do
  it 'should save' do
    Category.create(name: "Sci-fi")
    video = Video.new(title: "Star Wars", description: "Battles in space", large_cover_url: "https://via.placeholder.com/500x350.png?text=Star+...", small_cover_url: "https://via.placeholder.com/200x300.png?text=Star+...", category_id: Category.first.id)
    video.save
    expect(Video.first).to eq(video)
  end
end