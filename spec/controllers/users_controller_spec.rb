require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it { should redirect_to signin_path }
    end

    context "with invalid input" do
      before { post :create, user: {email: "gemille@example.com"} }

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it { should render_template('new') }
      
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "GET show" do
    it "sets the @user variable" do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end