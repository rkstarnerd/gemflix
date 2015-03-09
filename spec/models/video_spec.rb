require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "sherlock", description: "i am sherlocked")
    video.save
    expect(Video.first).to eq(video)
  end

  it "has many categories through video_categories" do
    sherlock = Video.create(id: 1, title: "sherlock")
    drama    = Category.create(id: 1, name: "drama")
    tv       = Category.create(id:2, name: "tv")
    video_category = VideoCategory.create(category_id: 1, video_id: 1)
    video_category = VideoCategory.create(category_id: 2, video_id: 1)
    expect(sherlock.categories).to include(drama, tv)
  end
end