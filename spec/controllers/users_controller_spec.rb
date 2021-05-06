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

      context "email sending" do
        it "sends the email" do
          post :create, params: { user: Fabricate.attributes_for(:user) }
          ActionMailer::Base.deliveries.should_not be_empty
        end

        it "sends the email to the right person" do
          post :create, params: { user: Fabricate.attributes_for(:user) }
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([User.first.email])
        end

        it "includes the right content" do
          post :create, params: { user: Fabricate.attributes_for(:user) }
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("welcome to MyFlix")
        end
      end
    end

    context "invalid input" do
      it "renders register template" do
        post :create, params: { user: Fabricate.attributes_for(:user, full_name: '', email: '', password: '') }
        expect(response).to render_template(:register)
      end

      it "doesn't send the email" do
        post :create, params: { user: Fabricate.attributes_for(:user, full_name: '', email: '', password: '') }
        ActionMailer::Base.deliveries.should be_empty
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

  describe "GET forgot_password" do
    context "user logged in" do
      before(:each) { login }
      it "redirects to home" do
        get :forgot_password
        expect(response).to redirect_to home_path
      end

      it "sets the flash message" do
        get :forgot_password
        expect(flash[:warning]).to eq("You are already logged in.")
      end
    end

    context "no user logged in" do
      it "renders forgot_password template" do
        get :forgot_password
        expect(response).to render_template :forgot_password
      end
    end
  end

  describe "POST forgot_password" do
    context "user logged in" do
      before(:each) { login }
      it "redirects to home" do
        post :forgot_password
        expect(response).to redirect_to home_path
      end

      it "sets the flash warning" do
        post :forgot_password
        expect(flash[:warning]).to eq("You are already logged in.")
      end
    end

    context "no user logged in" do
      context "valid email" do
        before(:each) do
          @user = Fabricate(:user)
          post :forgot_password, params: { email: @user.email }
        end
        
        it "sets the user based on email in params" do
          expect(assigns(:user)).to eq(@user)
        end

        it "sends the email" do
          ActionMailer::Base.deliveries.should_not be_empty
        end

        it "sets a random token on the user requesting a password reset" do
          expect(User.first.token).not_to be_empty
        end

        it "the email contains a link to reset_password/:token" do
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("<a href=\"/reset_password/#{User.first.token}\"")
        end

        it "redirects to the confirm password reset path" do
          expect(response).to redirect_to reset_password_confirmation_path
        end
      end

      context "invalid email" do
        before(:each) { post :forgot_password, params: { email: Faker::Internet.email } }

        it "redirects to forgot_password" do
          expect(response).to redirect_to forgot_password_path
        end

        it "sets the flash warning" do
          expect(flash[:warning]).to eq("No user matches the email address you entered.")
        end
      end
    end
  end

  describe "GET reset_password_confirmation" do
    context "no user logged in" do
      it "renders reset_password_confirmation template" do
        get :reset_password_confirmation
        expect(response).to render_template :reset_password_confirmation
      end
    end

    context "user logged in" do
      before(:each) do
        login
        get :reset_password_confirmation
      end

      it "redirects to home" do
        expect(response).to redirect_to home_path
      end

      it "sets the warning" do
        expect(flash[:warning]).to eq("You are already logged in.")
      end
    end
  end

  describe "GET reset_password/:token" do
    context "no user matches token" do
      it "redirects to root if no user matches token" do
        get :reset_password, params: { token: SecureRandom.urlsafe_base64 }
        expect(response).to redirect_to root_path
      end
    end

    context "user matches token" do
      before(:each) do
        token = SecureRandom.urlsafe_base64
        @user = Fabricate(:user, token: token)
        get :reset_password, params: { token: @user.token }
      end

      it "sets the user" do
        expect(assigns(:user)).to eq(@user)
      end

      it "renders the reset password template" do
        expect(response).to render_template(:reset_password)
      end
    end
  end

  describe "POST reset_password" do
    context "no user matches token" do
      it "redirects to root path" do
        token = SecureRandom.urlsafe_base64
        post :reset_password, params: { user: { password: 'new_password', token: token } }
        expect(response).to redirect_to root_path
      end
    end

    context "user matches token" do
      before(:each) do
        @user = Fabricate(:user, token: SecureRandom.urlsafe_base64, password: 'old_password')
        post :reset_password, params: { user: { password: 'new_password', token: @user.token } }
      end

      it "resets the password" do
        expect(@user.reload.authenticate('new_password')).to eq(@user.reload)
      end

      it "removes the token from user" do
        expect(@user.reload.token).to eq(nil)
      end

      it "sets the flash message" do
        expect(flash[:success]).to eq("Your password has been reset, please log in.")
      end

      it "redirects to login page" do
        expect(response).to redirect_to login_path
      end
    end
  end
end