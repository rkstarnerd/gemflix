require 'spec_helper'

describe User do
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:email)}
  it { should have_many(:queue_items).order(:position)}
  it { should have_many(:reviews).order(created_at: :desc) }

  describe "#queued_video?" do
    let(:user)  { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    it "returns true when the user queued the video" do
      Fabricate(:queue_item, user:user, video: video)
      user.queued_video?(video).should be_truthy
    end

    it "returns false when the user hasn't queued the video" do
      user.queued_video?(video).should be_falsey
    end    
  end

  describe "#follows?" do
    it "returns true if the user has a following relationship with another user" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: alice)
      expect(alice.follows?(bob)).to be_true
    end

    it "returns false if the user does not have a following relationship with another user"
  end
end