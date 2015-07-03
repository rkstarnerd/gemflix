def set_current_user(user=nil)
  session[:user_id]  = (user || Fabricate(:user)).id
end

def create_valid_user
  alice = Fabricate(:user)
  post :create, email: alice.email, password: alice.password
end

def create_invalid_user
  alice = Fabricate(:user)
  post :create, email: alice.email
end

def delete_user
  session[:user_id] = Fabricate(:user).id
  get :destroy
end

def set_video
  video = Fabricate(:video)
  get :show, id: video.id
end

def create_video
  Video.create(title: "foo", description: "bar")
end

def assign_category_to_videos
  Video.all.each do |video| 
    VideoCategory.create(video_id: video.id, category_id: 1)
  end
end

def user_signs_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end