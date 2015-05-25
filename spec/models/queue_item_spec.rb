require 'spec_helper'

describe QueueItem do
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: 'Sherlock')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Sherlock')
    end
  end
  
end