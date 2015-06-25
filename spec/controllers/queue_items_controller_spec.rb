require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue_items of the logged in user" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirects to the signin page for unauthenticated users" do
      get :index
      expect(response).to redirect_to('/signin')
    end
  end

  describe "POST create" do
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates queue_item" do
      session[:user_id] = Fabricate(:user)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "the queue item that is associated with the video" do
      session[:user_id] = Fabricate(:user)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the signed in user" do
      user = Fabricate(:user)
      session[:user_id] = user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user)
    end

    it "puts the video as the last one in the queue" do
      user = Fabricate(:user)
      session[:user_id] = user
      video = Fabricate(:video)
      Fabricate(:queue_item, video: video, user: user)
      video2 = Fabricate(:video)
      post :create, video_id: video2.id
      video2_queue_item = QueueItem.where(video_id: video2.id, user_id: user.id).first
      expect(video2_queue_item.position).to eq(2)
    end

    it "does not add the video to the queue if it is already in the queue" do
      user = Fabricate(:user)
      session[:user_id] = user
      video = Fabricate(:video)
      Fabricate(:queue_item, video: video, user: user)
      post :create, video_id: video.id
      expect(user.queue_items.count).to eq(1)
    end

    it "redirects to the sign in page for unauthenticated users" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to('/signin')
    end
  end

  describe "DELETE destroy" do
    it "redirect_to my_queue_path" do
      session[:user_id] = Fabricate(:user)
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to(my_queue_path)
    end

    it "removes the item from the queue" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, user: user)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "does not delete the queue item if the queue_item is not in the current user's queue" do
      user  = Fabricate(:user)
      user2 = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, user: user2)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    
    it "redirects to the sign in page for unauthenticated users" do
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to('/signin')
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      it "redirects to the my queue page" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, user: user, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, user: user, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, user: user, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(user.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do
      it "redirects to the my queue page" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, user: user, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message"
      it "does not change the queue items"
    end

    context "with unauthenticated users"    
    context "with queue items that do not belong to the current user"
  end
end