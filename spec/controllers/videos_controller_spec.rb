require 'rails_helper.rb'
require 'faker'

describe VideosController do
  def login
    session[:user_id] = Fabricate(:user).id
  end

  describe "GET index" do
    before(:all) do
      @categories = []
      5.times do
        @categories << Category.create(name: Faker::Lorem.words(2).join(" "))
      end
    end

    after(:all) do
      Category.delete_all
    end

    it "sets categories" do
      login
      get :index
      expect(assigns(:categories)).to eq(@categories)
    end

    it "renders home" do
      login
      get :index
      expect(response).to render_template(:home)
    end
  end

  describe "GET show" do
    before(:all) do
      @video = Fabricate(:video)
    end

    after(:all) do
      Video.delete_all
    end

    it "sets video" do
      login
      get :show, params: { id: @video.id }
      expect(assigns(:video)).to eq(@video)
    end

    it "renders video" do
      login
      get :show, params: { id: @video.id }
      expect(response).to render_template(:video)
    end
  end

  describe "GET search" do
    before(:all) do
      Fabricate(:video, title: "Star Wars")
    end

    after(:all) do
      Video.delete_all
    end

    it "sets videos" do
      login
      get :search, params: { "search-term": "Star" }
      expect(assigns(:videos)).to eq([Video.first])
    end

    it "renders search" do
      login
      get :search, params: { "search-term": "Star" }
      expect(response).to render_template(:search)
    end
  end
end