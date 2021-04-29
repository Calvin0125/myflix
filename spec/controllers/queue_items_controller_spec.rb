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

  describe "DELETE queue_items/:id" do
    context "no user logged in" do
      it "should redirect to root" do
        delete :destroy, params: { id: 1 }
        expect(response).to redirect_to root_path
      end
    end

    context "user logged in" do
      it "should delete the queue item" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item = Fabricate(:queue_item, user_id: user.id)
        delete :destroy, params: { id: queue_item.id }
        expect(user.queue_items.length).to eq(0)
      end

      it "should redirect to my_queue" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item = Fabricate(:queue_item, user_id: user.id)
        delete :destroy, params: { id: queue_item.id }
        expect(response).to redirect_to my_queue_path
      end
    end
  end

  describe "POST update" do
    context "valid input" do
      it "updates the positions of the logged in user's queue items" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_items = []
        3.times { |n| queue_items << Fabricate(:queue_item, position: n + 1, video_id: n + 1, user_id: user.id) }
        post :update, params: { positions: { "1": "1", "2": "3", "3": "3"}, reviews: [{id: '', rating: ''}] }
        expect(user.queue_items.where(position: 3).first).to eq(queue_items[1])
      end 

      it "updates and creates reviews based on user input" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        review1 = Fabricate(:review, user_id: user.id, video_id: video1.id, rating: 3)
        reviews_array = [{ id: review1.id.to_s, video_id: video1.id.to_s, rating: '4' },
                         { id: '', video_id: video2.id.to_s, rating: '5' }]
        post :update, params: { positions: {}, reviews: reviews_array }
        expect(user.reviews.where(video: video1).first.rating).to eq(4)
        expect(user.reviews.where(video: video2).first.rating).to eq(5)
      end

      it "redirects to my_queue" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_items = []
        3.times { |n| queue_items << Fabricate(:queue_item, position: n + 1, video_id: n + 1, user_id: user.id) }
        post :update, params: { positions: { "1": "3", "2": "3", "3": "3"}, reviews: [{id: '', rating: ''}] }
        expect(response).to redirect_to my_queue_path
      end
    end

    context "invalid input" do
      it "displays error if user tries to change more than one position" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_items = []
        3.times { |n| queue_items << Fabricate(:queue_item, position: n + 1, video_id: n + 1, user_id: user.id) }
        post :update, params: { positions: { "1": "3", "2": "3", "3": "3"}, reviews: [{id: '', rating: ''}] }
        expect(flash[:warning]).to eq("Your queue was not updated, please update one item at a time with an integer.")
      end

      it "displays error if user enters something other than integer" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_items = []
        3.times { |n| queue_items << Fabricate(:queue_item, position: n + 1, video_id: n + 1, user_id: user.id) }
        post :update, params: { positions: { "1": "1", "2": "3.5", "3": "3"}, reviews: [{id: '', rating: ''}] }
        expect(flash[:warning]).to eq("Your queue was not updated, please update one item at a time with an integer.")
      end

      it "redirects to my_queue" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_items = []
        3.times { |n| queue_items << Fabricate(:queue_item, position: n + 1, video_id: n + 1, user_id: user.id) }
        post :update, params: { positions: { "1": "3", "2": "3", "3": "3"}, reviews: [{id: '', rating: ''}] }
        expect(response).to redirect_to my_queue_path
      end
    end
  end
end