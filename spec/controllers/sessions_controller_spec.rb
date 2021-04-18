require 'rails_helper.rb'

describe SessionsController do
  describe "GET new" do
    it "renders the login template if no user logged in" do
      get :new
      expect(response).to render_template :login
    end

    it "redirects to home if logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to home_path
    end

    it "sets the notice if logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(flash[:warning]).to eq("You are already logged in.")
    end
  end

  describe "POST create" do
    context "valid input" do
      before(:all) do
        @user = Fabricate(:user, password: "password")
      end

      after(:all) do
        User.delete_all
      end

      it "logs in the user" do
        post :create, params: { email: @user.email, password: "password" }
        expect(session[:user_id]).to eq(@user.id)
      end

      it "sets the notice" do
        post :create, params: { email: @user.email, password: "password" }
        expect(flash[:success]).to eq("You have been logged in.")
      end

      it "redirects to home" do
        post :create, params: { email: @user.email, password: "password" }
        expect(response).to redirect_to home_path
      end
    end

    context "invalid input" do
      before(:all) do
        @user = Fabricate(:user, email: "hello@gmail.com", password: "password")
      end

      after(:all) do
        User.delete_all
      end

      it "doesn't log in the user if email is invalid" do
        post :create, params: { email: "wrong@email.com", password: "password" }
        expect(session[:user_id]).to eq(nil)
      end

      it "doesn't log in the user if password is invalid" do
        post :create, params: { email: "hello@gmail.com", password: "wrong_password" }
        expect(session[:user_id]).to eq(nil)
      end

      it "sets the notice" do
        post :create, params: { email: "wrong@gmail.com", password: "wrong_password" }
        expect(flash[:danger]).to eq("Invalid username or password.")
      end

      it "renders login template" do
        post :create, params: { email: "wrong@gmail.com", password: "wrong_password" }
        expect(response).to render_template(:login)
      end
    end
  end
end