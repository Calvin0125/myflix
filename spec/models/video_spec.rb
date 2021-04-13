require 'rails_helper'

describe Video do
  describe 'associations' do
    it { should belong_to(:category).optional }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe '::search_by_title' do
    before :all do
      @star_wars = Video.create(title: 'Star Wars', description: 'space battles')
      @star_trek = Video.create(title: 'Star Trek', description: 'space voyages')
      @rick_and_morty = Video.create(title: 'Rick and Morty', description: 'funny cartoon')
      @his_dark_materials = Video.create(title: 'His Dark Materials', description: 'allegorical fantasy')
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
  end
end