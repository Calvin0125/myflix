require 'rails_helper.rb'

describe ReviewsController do
  context "not logged in" do
    it_behaves_like "a page for logged in users only" do
      let(:action) { post :create, params: { review: Fabricate.attributes_for(:review) } }
    end
  end

  context "logged in" do
    before(:each) { login }
    context "valid input" do
      it "saves review" do
        post :create, params: { review: Fabricate.attributes_for(:review) }
        expect(Review.all.length).to eq(1)
      end

      it "redirects to the page for the video that the review belongs to" do
        video = Fabricate(:video)
        post :create, params: { review: Fabricate.attributes_for(:review, video_id: video.id) }
        expect(response).to redirect_to(video_path(video))
      end

      it "sets the flash success" do
        post :create, params: { review: Fabricate.attributes_for(:review) }
        expect(flash[:success]).to eq("Your review was added.")
      end

      it "associates the review with logged in user" do
        post :create, params: { review: Fabricate.attributes_for(:review, user_id: current_user.id) }
        expect(assigns(:review).user).to eq(current_user)
      end

      it "associates the review with the video" do
        video = Fabricate(:video)
        post :create, params: { review: Fabricate.attributes_for(:review, video_id: video.id) }
        expect(assigns(:review).video).to eq(video)
      end
    end

    context "invalid input" do
      it "redirects to page for the video that the review belongs to" do
        video = Fabricate(:video)
        post :create, params: { review: Fabricate.attributes_for(:review, body: '', video_id: video.id) }
        expect(response).to redirect_to(video_path(video))
      end

      it "sets flash error" do
        post :create, params: { review: Fabricate.attributes_for(:review, body: '') }
        expect(flash[:danger]).to eq("Your review was not added, please select a rating and fill in the textbox.")
      end
    end
  end
end