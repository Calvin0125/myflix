require 'rails_helper.rb'

describe UsersController do
  describe "GET new" do
    it "sets @user to new User object" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "renders register template" do
      get :new
      expect(response).to render_template(:register)
    end
  end

  describe "POST create" do
    it "sets user based on params" do
      post :create, params: { user: Fabricate.attributes_for(:user) }
      expect(assigns(:user)).to eq(User.first)
    end

    context "valid input" do
      it "sets flash notice" do
        post :create, params: { user: Fabricate.attributes_for(:user) }
        expect(flash[:success]).to eq("Your account has been created, please log in.")
      end

      it "redirects to login" do
        post :create, params: { user: Fabricate.attributes_for(:user) }
        expect(response).to redirect_to(login_path)
      end
    end

    context "invalid input" do
      it "renders register template" do
        post :create, params: { user: Fabricate.attributes_for(:user, full_name: '', email: '', password: '') }
        expect(response).to render_template(:register)
      end
    end
  end

  describe "GET user/:id" do
    before(:each) { @bob = Fabricate(:user) }

    context "logged in user" do
      before(:each) { login }

      it "sets @user based on params id" do
        get :show, params: { id: @bob.id }
        expect(assigns(:user)).to eq(@bob)
      end

      it "renders the show user template" do
        get :show, params: { id: @bob.id }
        expect(response).to render_template :show
      end
    end

    context "no user logged in" do
      it_behaves_like "a page for logged in users only" do
        let(:action) { get :show, params: { id: @bob.id } }
      end

      it "sets the flash notice" do
        get :show, params: { id: @bob.id }
        expect(flash[:danger]).to eq("You must be logged in to do that.")
      end
    end
  end
end