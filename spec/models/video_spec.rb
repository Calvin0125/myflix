require 'rails_helper'

describe Video do
  describe 'associations' do
    it { should belong_to(:category).optional }
    it { should have_many(:reviews) }
    it { should have_many(:queue_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe '::search_by_title' do
    before :all do
      @star_wars = Fabricate(:video, title: "Star Wars")
      @star_trek = Fabricate(:video, title: "Star Trek")
      @rick_and_morty = Fabricate(:video, title: "Rick and Morty")
      @his_dark_materials = Fabricate(:video, title: "His Dark Materials")
    end

    after :all do
      Video.delete_all
    end

    it "returns empty array if no matching videos found" do
      result = Video.search_by_title('Family Guy')
      expect(result).to eq([])
    end

    it "returns single video in an array for partial match" do
      cartoon = Video.search_by_title('Rick')
      expect(cartoon).to contain_exactly(@rick_and_morty)
    end

    it "returns single video in an array for exact match" do
      space_battles = Video.search_by_title('Star Wars')
      expect(space_battles).to contain_exactly(@star_wars)
    end

    it "returns multiple matches in an array" do
      space_movies = Video.search_by_title('Star')
      expect(space_movies).to contain_exactly(@star_trek, @star_wars)
    end

    it "is case insensitive" do
      fantasy_series = Video.search_by_title('his DARK matERials')
      expect(fantasy_series).to contain_exactly(@his_dark_materials)
    end

    it "returns empty array when searching with empty string" do
      result = Video.search_by_title('')
      expect(result).to eq([])
    end
  end

  describe "#average_rating" do
    before(:each) do
      @video = Fabricate(:video)
    end

    it "returns nil if there are no reviews" do
      expect(@video.average_rating).to eq(nil)
    end

    it "returns rating if one review" do
      @video.reviews << Fabricate(:review, rating: 4)
      expect(@video.average_rating).to eq('4.0')
    end

    it "returns rating to one decimal place for whole numbers" do
      3.times { |n| @video.reviews << Fabricate(:review, rating: 4, user_id: n) }
      expect(@video.average_rating).to eq('4.0')
    end

    it "rounds to one decimal place for decimal numbers" do
      @video.reviews << [Fabricate(:review, rating: 2, user_id: 1), Fabricate(:review, rating: 3, user_id: 2), Fabricate(:review, rating: 3, user_id: 3)]
      expect(@video.average_rating).to eq('2.7')
    end
  end

  describe "#already in queue" do
    before(:each) do
      @user = Fabricate(:user)
      @video = Fabricate(:video)
    end
    
    it "returns true if the video is already in the user's queue" do
      Fabricate(:queue_item, position: 1, user_id: @user.id, video_id: @video.id)
      expect(@video.already_in_queue(@user)).to eq(true)
    end

    it "returns false if the video is not in the user's queue" do
      expect(@video.already_in_queue(@user)).to eq(false)
    end
  end
end