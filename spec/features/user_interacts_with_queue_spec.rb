require 'spec_helper'

feature "user interacts with the queue" do
  scenario "user adds and reorders videos in the queue" do
    drama = Category.create(id: 1, name: "drama")
    video1 = Fabricate(:video)
    video2 = Fabricate(:video)
    video3 = Fabricate(:video)
    assign_category_to_videos
    
    user_signs_in

    #test link to add video to the queue
    add_video_to_queue(video1)
    expect_video_to_be_in_queue(video1)

    #test that "+ My Queue" button is not present if video is already in the queue
    visit video_path(video1)
    page.should_not have_content "+ My Queue"

    #add multiple videos to the queue
    add_video_to_queue(video2)
    add_video_to_queue(video3)

    #test reordering videos
    set_video_position(video1, 3)
    set_video_position(video2, 1)
    set_video_position(video3, 2)

    click_button "Update Instant Queue"

    expect_video_position(video2, 1)
    expect_video_position(video3, 2)
    expect_video_position(video1, 3)
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
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