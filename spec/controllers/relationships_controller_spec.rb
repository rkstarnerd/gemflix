require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @relationships to the current user following relationships" do
      alice = Fabricate(:user)
      set_current_user
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follwer: alice, leader: bob)
      get :index
      expect(assigns(:relationship)).to eq([relationship])
    end
  end
end