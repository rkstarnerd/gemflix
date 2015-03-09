require 'spec_helper'

describe VideoCategory do
  it "saves itself" do
    video_category = VideoCategory.new(category_id: 1, video_id: 1)
    video_category.save
    expect(VideoCategory.first).to eq(video_category)
  end

  it "belongs to a video and category" do
    sherlock = Video.create(id: 1, title: "Sherlock")
    drama    = Category.create(id: 1, name: "drama")
    video_category = VideoCategory.create(category_id: 1, video_id: 1)
    expect(sherlock.video_categories).to include(video_category)
    expect(drama.video_categories).to include(video_category)
  end
end