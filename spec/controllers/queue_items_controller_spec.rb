require 'rails_helper.rb'

describe QueueItemsController do
  describe "GET show" do
    context "no user logged in" do
      it "redirects to login page" do
        get :show
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
        get :show
        expect(assigns(:queue_items)).to eq([logged_in_queue_item1, logged_in_queue_item2])
      end
    end
  end
end