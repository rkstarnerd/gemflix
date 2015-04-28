require 'spec_helper'

describe VideosController do
  it { should use_before_action(:require_user)   }

  describe "GET show" do
    it "sets the @video variable when user is logged in" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects to the sign in page when user is not logged in" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to signin_path
    end
  end

  describe "POST search" do
    it { should use_before_action(:set_categories) }

    it "sets the @videos variable when user is logged in" do
      session[:user_id] = Fabricate(:user).id
      sherlock = Fabricate(:video, title: 'Sherlock', description: 'sleuth')
      post :search, search_term: 'lock'
      expect(assigns(:videos)).to eq([sherlock])
    end

    it "does not render the search template when the user is not logged in" do
      get :search
      expect(response).to redirect_to signin_path
    end
  end
end