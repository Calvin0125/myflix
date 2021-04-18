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
      4.times { videos.unshift(Fabricate(:video)) }
      @favorites.videos << videos
      expect(@favorites.recent_videos).to eq(videos)

      2.times { videos.unshift(Fabricate(:video)) }
      @favorites.videos << videos
      expect(@favorites.recent_videos).to eq(videos)
    end

    it "returns 6 most recent videos if more than 6 in category" do
      videos = []
      10.times { Fabricate(:video) }
      @favorites.videos << videos
      expect(@favorites.recent_videos).to eq(videos.slice(0, 6))
    end
  end
end