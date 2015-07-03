require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    drama = Category.create(id: 1, name: "drama")
    video1 = Fabricate(:video)
    video2 = Fabricate(:video)
    video3 = Fabricate(:video)
    assign_category_to_videos
    
    #test video links
    user_signs_in
    find("a[href='/videos/#{video1.id}']").click
    page.should have_content(video1.title)
    
    #test link to add video to the queue
    click_link "+ My Queue"
    page.should have_content(video1.title)

    #test that "+ My Queue" button is not there if video is already in the queue
    visit video_path(video1)
    page.should_not have_content "+ My Queue"

    #test adding multiple videos to the queue
    visit home_path
    find("a[href='/videos/#{video2.id}']").click
    click_link "+ My Queue"
    visit home_path
    find("a[href='/videos/#{video3.id}']").click
    click_link "+ My Queue"

    #test reordering videos
    set_video_position(video1, 3)
    set_video_position(video2, 1)
    set_video_position(video3, 2)

    click_button "Update Instant Queue"

    expect_video_position(video2, 1)
    expect_video_position(video3, 2)
    expect_video_position(video1, 3)
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do 
      fill_in "queue_items[][position]", with: "#{position}"
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq("#{position}")
  end
end