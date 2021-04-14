require 'rails_helper'
describe Category do
  it { should have_many :videos }

  describe '#recent_videos' do
    before(:all) do
      @favorites = Category.create(name: 'favorites')
    end

    after(:all) do
      Category.delete_all
    end

    it "returns empty array if no videos in category" do
      expect(@favorites.recent_videos).to eq([])
    end

    it "returns all videos if 6 or fewer in category" do
      videos = []
      videos.unshift Video.create(title: 'Star Wars', description: 'space battles', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Star Trek', description: 'space voyages', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Rick and Morty', description: 'funny cartoon', category_id: Category.first.id)
      videos.unshift Video.create(title: 'His Dark Materials', description: 'allegorical fantasy', category_id: Category.first.id)
      expect(@favorites.recent_videos).to eq(videos)

      videos.unshift Video.create(title: 'Lord of the Rings', description: 'allegorical fantasy', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Scooby Doo', description: 'childrens cartoon', category_id: Category.first.id)
      expect(@favorites.recent_videos).to eq(videos)
    end

    it "returns 6 most recent videos if more than 6 in category" do
      videos = []
      videos.unshift Video.create(title: 'Star Wars', description: 'space battles', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Star Trek', description: 'space voyages', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Rick and Morty', description: 'funny cartoon', category_id: Category.first.id)
      videos.unshift Video.create(title: 'His Dark Materials', description: 'allegorical fantasy', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Lord of the Rings', description: 'allegorical fantasy', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Scooby Doo', description: 'childrens cartoon', category_id: Category.first.id)
      videos.unshift Video.create(title: 'The Ring', description: 'horror movie about a ring', category_id: Category.first.id)
      videos.unshift Video.create(title: 'Inception', description: 'movie about space', category_id: Category.first.id)
      expect(@favorites.recent_videos).to eq(videos.slice(0, 6))
    end
  end
end