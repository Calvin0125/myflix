require 'rails_helper.rb'

describe RelationshipsController do
  describe "GET index" do
    context "logged in user" do
      before(:all) do
        @following_user = Fabricate(:user)
        @leading_user1 = Fabricate(:user)
        @leading_user2 = Fabricate(:user)
        @relationship1 = Fabricate(:relationship, follower_id: @following_user.id, 
                                                leader_id: @leading_user1.id)
        @relationship2 = Fabricate(:relationship, follower_id: @following_user.id, 
          leader_id: @leading_user2.id)
      end

      after(:all) do
        User.delete_all
        Relationship.delete_all
      end

      it "sets @relationships to the logged in users following relationships" do
        session[:user_id] = @following_user.id
        get :index
        expect(assigns(:relationships)).to eq([@relationship1, @relationship2])
      end

      it "renders the index template" do
        session[:user_id] = @following_user.id
        get :index
        expect(response).to render_template :index
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { get :index }
      end
    end
  end

  describe "POST create" do
    context "logged in user" do
      before(:each) do
        @leading_user = Fabricate(:user)
        login
      end

      context "valid input" do
        it "creates a following relationship for the current user with the user being viewed" do
          post :create, params: { leader_id: @leading_user.id }
          expect(current_user.following_relationships.count).to eq(1)
          expect(current_user.following_relationships.first.leader).to eq(@leading_user)
        end

        it "sets the flash message" do
          post :create, params: { leader_id: @leading_user.id }
          expect(flash[:success]).to eq("You are following #{@leading_user.full_name}")
        end

        it "redirects to the leading user's profile page" do
          post :create, params: { leader_id: @leading_user.id }
          expect(response).to redirect_to user_path(@leading_user.id)
        end
      end

      context "invalid input" do
        it "doesn't create the relationship" do
          post :create, params: { leader_id: current_user.id }
          expect(current_user.following_relationships.count).to eq(0)
        end

        it "sets the flash message" do
          Fabricate(:relationship, follower: current_user, leader: @leading_user)
          post :create, params: { leader_id: @leading_user.id }
          expect(flash[:danger]).to eq("Your request to follow #{@leading_user.full_name} could not be completed.")
        end

        it "redirects to the leading user's profile page" do
          Fabricate(:relationship, follower: current_user, leader: @leading_user)
          post :create, params: { leader_id: @leading_user.id }
          expect(response).to redirect_to user_path(@leading_user.id)
        end
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { post :create }
      end
    end
  end

  describe "DELETE destroy" do
    context "logged in user" do
      before(:each) do
        @following_user = Fabricate(:user)
        @leading_user1 = Fabricate(:user)
        @leading_user2 = Fabricate(:user)
        @relationship1 = Fabricate(:relationship, follower_id: @following_user.id, 
                                                leader_id: @leading_user1.id)
        @relationship2 = Fabricate(:relationship, follower_id: @following_user.id, 
          leader_id: @leading_user2.id)
      end

      it "deletes the correct relationship" do
        session[:user_id] = @following_user.id
        delete :destroy, params: { id: @relationship2.id }
        expect(@following_user.following_relationships).to eq([@relationship1])
      end

      it "doesn't delete a relationship where the logged in user is not the follower" do
        session[:user_id] = @leading_user1.id
        delete :destroy, params: { id: @relationship1.id }
        expect(@following_user.following_relationships).to eq([@relationship1, @relationship2])
      end

      it "redirects to people path" do
        session[:user_id] = @following_user.id
        delete :destroy, params: { id: @relationship1.id }
        expect(response).to redirect_to people_path
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { delete :destroy, params: { id: 1 } }
      end
    end
  end
end