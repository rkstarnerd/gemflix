require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user }
      
      context "with valid inputs" do
        before { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
        it "creates a review" do
          expect(Review.count).to eq(1)
        end
        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end
        it "creates a review associated with the signed in user" do
          expect(Review.first.user).to eq(current_user)
        end
        it "redirects to video show page" do
          expect(response).to redirect_to(video)
        end
      end

      context "with invalid inputs" do
        before { post :create, review: {rating: 4}, video_id: video.id }
        
        it "does not create a review" do
          expect(Review.count).to eq(0)
        end
        it "renders the video/show template" do
          expect(response).to render_template "videos/show"
        end
        it "sets @video" do
          expect(assigns(:video)).to eq(video)
        end
        it "sets @reviews" do
          review = Fabricate(:review, video: video)
          post :create, review: {rating: 4}, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end
    

    context "with unauthenticated users" do
      it "redirects to sign in path" do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to(signin_path)
      end
    end
  end
end