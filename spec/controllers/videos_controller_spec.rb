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
  end

    it "redirects to the sign in page when user is not logged in" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to signin_path
    end
  end

#   describe "GET search" do
#     it { should use_before_action(:set_categories) }

#     it "sets the @videos variable" do
#     end
#     it "renders the search template when user is logged in" do
#       get :search
#       expect(response).to render_template :search
#     end

#     it "does not render the search template when the user is not logged in" do
#       get :search
#       expect(response).to eq([signin_path])
#     end
#   end
# end