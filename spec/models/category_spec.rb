require 'spec_helper'

describe Category do
  it "saves itself" do
    category = Category.new(name: "drama")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos through video_categories" do
    category = Category.create(id: 1, name: "drama")
    sherlock = Video.create(id: 1, title: "Sherlock")
    break_bad = Video.create(id: 2,title: "Breaking Bad")
    video_category = VideoCategory.create(category_id: 1, video_id: 1)
    video_category = VideoCategory.create(category_id: 1, video_id: 2)
    expect(category.videos).to include(sherlock, break_bad)
  end
end