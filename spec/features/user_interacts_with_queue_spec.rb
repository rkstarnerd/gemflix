require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    drama = Category.create(id: 1, name: "drama")
    video  = Fabricate(:video)
    video2 = Fabricate(:video)
    assign_category_to_videos
    
    user_signs_in
    find("a[href='/videos/#{video.id}']").click
    page.should have_content(video.title)
    
    click_link "+ My Queue"
    page.should have_content(video.title)

    visit video_path(video)
    page.should_not have_content "+ My Queue"
  end  
end