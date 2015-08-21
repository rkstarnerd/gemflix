require 'spec_helper'

feature 'User following' do
  scenario "user follows and unfollows someone" do
    alice = Fabricate(:user)
    bob = Fabricate(:user)
    category = Category.create(id: 1, name: "drama")
    video = Fabricate(:video)
    assign_category_to_videos(category)
    Fabricate(:review, user: alice, video: video)

    user_signs_in(bob)
    click_on_video_on_home_page(video)
    click_link alice.name
    click_link "Follow"
    expect(page).to have_content(alice.name)

    unfollow(alice)
    expect(page).not_to have_content(alice.name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end
