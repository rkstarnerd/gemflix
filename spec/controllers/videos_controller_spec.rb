require 'spec_helper'

describe VideosController do
  it { should use_before_action(:require_user)   }

  describe "GET show" do
    before { set_video }

    it "sets the @video variable when user is logged in" do
      set_current_user
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets the @reviews variable when user is logged in" do
      set_current_user
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it { should redirect_to(signin_path) }
  end

  describe "POST search" do
    it { should use_before_action(:set_categories) }

    it "sets the @videos variable when user is logged in" do
      set_current_user
      sherlock = Fabricate(:video, title: 'Sherlock', description: 'sleuth')
      post :search, search_term: 'lock'
      expect(assigns(:videos)).to eq([sherlock])
    end

    it "does not render the search template when the user is not logged in" do
      sherlock = Fabricate(:video, title: 'Sherlock', description: 'sleuth')
      post :search, search_term: 'lock'
      expect(response).to redirect_to signin_path
    end
  end
end