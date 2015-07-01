require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue_items of the logged in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
        let(:action) { get :index }
    end
  end

  describe "POST create" do
    let(:video)  { Fabricate(:video) }

    it_behaves_like "redirects to my_queue_path" do
      let(:action) { post :create, video_id: video.id }
    end

    it "creates queue_item" do
      set_current_user
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "it creates the queue item that is associated with the video" do
      set_current_user
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the signed in user" do
      user = Fabricate(:user)
      set_current_user(user)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user)
    end

    it "puts the video as the last one in the queue" do
      user = Fabricate(:user)
      set_current_user(user)
      Fabricate(:queue_item, video: video, user: user)
      video2 = Fabricate(:video)
      post :create, video_id: video2.id
      video2_queue_item = QueueItem.where(video_id: video2.id, user_id: user.id).first
      expect(video2_queue_item.position).to eq(2)
    end

    it "does not add the video to the queue if it is already in the queue" do
      user = Fabricate(:user)
      set_current_user(user)
      Fabricate(:queue_item, video: video, user: user)
      post :create, video_id: video.id
      expect(user.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: video.id }
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "redirects to my_queue_path" do
      let(:queue_item) { Fabricate(:queue_item) }
      let(:action)     { delete :destroy, id: queue_item.id }
    end

    it "removes the item from the queue" do
      user = Fabricate(:user)
      set_current_user(user)
      queue_item = Fabricate(:queue_item, user: user)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "does not delete the queue item if the queue_item is not in the current user's queue" do
      user  = Fabricate(:user)
      user2 = Fabricate(:user)
      set_current_user(user)
      queue_item = Fabricate(:queue_item, user: user2)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    
    it_behaves_like "requires sign in" do
       let(:queue_item) {  Fabricate(:queue_item) }
       let(:action)     { delete :destroy, id: queue_item.id}
    end

    it "normalizes the remaining queue items" do
      user = Fabricate(:user)
      set_current_user(user)
      queue_item1 = Fabricate(:queue_item, user: user, position: 1)
      queue_item2 = Fabricate(:queue_item, user: user, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      let(:video) { Fabricate(:video) }
      let(:user)  { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: user, video: video, position: 2) }
    
      before { set_current_user(user) }

      it_behaves_like "redirects to my_queue_path" do
        let(:action) { post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}] }
      end

      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(user.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do
      let(:video) { Fabricate(:video) } 
      let(:user)  { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: user, video: video, position: 2) }
    
      before { set_current_user(user) }

      it_behaves_like "redirects to my_queue_path" do
        let(:action) { post :update_queue, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}] }
      end

      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}]
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 1, position: 2}, {id: 2, position: 1}] }
    end

    context "with queue items that do not belong to the current user" do 
      it "does not change the queue items" do
        user  = Fabricate(:user)
        user1 = Fabricate(:user)
        set_current_user(user)
        video  = Fabricate(:video)
        video2 = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: user1, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user, video: video2, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
end