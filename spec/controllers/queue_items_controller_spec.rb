require 'rails_helper.rb'

describe QueueItemsController do
  describe "GET show" do
    context "no user logged in" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context "user logged in" do
      it "assigns queue items only for logged in user to @queue_items" do
        logged_in_user = Fabricate(:user)
        other_user = Fabricate(:user)
        session[:user_id] = logged_in_user.id
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        logged_in_queue_item1 = Fabricate(:queue_item, position: 1, video_id: video1.id, user_id: logged_in_user.id)
        logged_in_queue_item2 = Fabricate(:queue_item, position: 2, video_id: video2.id, user_id: logged_in_user.id)
        other_queue_item = Fabricate(:queue_item, position: 1, video_id: video1.id, user_id: other_user.id)
        get :index
        expect(assigns(:queue_items)).to eq([logged_in_queue_item1, logged_in_queue_item2])
      end
    end
  end

  describe "POST create" do
    context "no user logged in" do
      it "redirects to login page" do
        post :create
        expect(response).to redirect_to root_path
      end
    end

    context "user logged in" do
      context "valid queue item" do
        it "creates a new queue item" do
          session[:user_id] = Fabricate(:user).id
          post :create, params: { queue_item: Fabricate.attributes_for(:queue_item) }
          expect(QueueItem.count).to eq(1)
        end

        it "sets the flash message" do
          session[:user_id] = Fabricate(:user).id
          post :create, params: { queue_item: Fabricate.attributes_for(:queue_item) }
          expect(flash[:success]).to eq("This video has been added to your queue.")
        end

        it "redirects to video path" do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          post :create, params: { queue_item: Fabricate.attributes_for(:queue_item, video_id: video.id) }
          expect(response).to(redirect_to video_path(video))
        end
      end

      context "invalid queue item" do
        it "doesn't create a new queue item" do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          Fabricate(:queue_item, video_id: video.id)
          post :create, params: { queue_item: Fabricate.attributes_for(:queue_item, video_id: video.id) }
          expect(QueueItem.count).to eq(1)
        end

        it "sets the flash message" do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          Fabricate(:queue_item, video_id: video.id)
          post :create, params: { queue_item: Fabricate.attributes_for(:queue_item, video_id: video.id) }
          expect(flash[:warning]).to eq("This video is already in your queue.")
        end

        it "redirects to video path" do
          session[:user_id] = Fabricate(:user).id
          video = Fabricate(:video)
          Fabricate(:queue_item, video_id: video.id)
          post :create, params: { queue_item: Fabricate.attributes_for(:queue_item, video_id: video.id) }
          expect(response).to redirect_to video_path(video)
        end
      end
    end
  end
end