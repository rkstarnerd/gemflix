require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    before { get :new }

    it { should render_template('new') }

    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      before { create_valid_user }

      it "puts the signed in user in the session" do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end

      it { should redirect_to home_path }
      it { should set_flash }
    end

    context "with invalid credentials" do
      before { create_invalid_user }

      it { should set_session }
      it { should set_flash }
      it { should redirect_to signin_path }
    end
  end

  describe "GET destroy" do
    before { delete_user }

    it "clears the session for the user" do
      expect(session[:user_id]).to eq(nil)
    end

    it { should redirect_to root_path }
    it { should set_flash }
  end
end