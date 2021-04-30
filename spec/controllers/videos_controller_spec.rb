require 'rails_helper.rb'
require 'faker'

describe VideosController do
  describe "GET index" do
    context "user logged in" do
      before(:each) { login }
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
        get :index
        expect(assigns(:categories)).to eq(@categories)
      end

      it "renders home" do
        get :index
        expect(response).to render_template(:home)
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { get :index }
      end
    end
  end

  describe "GET show" do
    context "user logged in" do
      before(:each) { login }

      before(:all) do
        @video = Fabricate(:video)
      end

      after(:all) do
        Video.delete_all
      end

      it "sets video" do
        get :show, params: { id: @video.id }
        expect(assigns(:video)).to eq(@video)
      end

      it "renders video" do
        get :show, params: { id: @video.id }
        expect(response).to render_template(:video)
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { get :show, params: { id: Fabricate(:video).id } }
      end
    end
  end

  describe "GET search" do
    context "user logged in" do
      before(:each) { login }

      before(:all) do
        Fabricate(:video, title: "Star Wars")
      end

      after(:all) do
        Video.delete_all
      end

      it "sets videos" do
        get :search, params: { "search-term": "Star" }
        expect(assigns(:videos)).to eq([Video.first])
      end

      it "renders search" do
        get :search, params: { "search-term": "Star" }
        expect(response).to render_template(:search)
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { get :search, params: { "search-term": "Star" } }
      end
    end
  end
end