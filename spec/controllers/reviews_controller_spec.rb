require 'rails_helper.rb'

describe ReviewsController do
  def login
    session[:user_id] = Fabricate(:user).id
  end

  context "valid input" do
    it "saves review" do
      login
      post :create, params: { review: Fabricate.attributes_for(:review) }
      expect(Review.all.length).to eq(1)
    end

    it "redirects to the page for the video that the review belongs to" do
      login
      video = Fabricate(:video)
      post :create, params: { review: Fabricate.attributes_for(:review, video_id: video.id) }
      expect(response).to redirect_to(video_path(video))
    end

    it "sets the flash success" do
      login
      post :create, params: { review: Fabricate.attributes_for(:review) }
      expect(flash[:success]).to eq("Your review was added.")
    end
  end

  context "invalid input" do
    it "redirects to page for the video that the review belongs to" do
      login
      video = Fabricate(:video)
      post :create, params: { review: Fabricate.attributes_for(:review, body: '', video_id: video.id) }
      expect(response).to redirect_to(video_path(video))
    end

    it "sets flash error" do
      login
      post :create, params: { review: Fabricate.attributes_for(:review, body: '') }
      expect(flash[:danger]).to eq("Your review was not added, please select a rating and fill in the textbox.")
    end
  end
end