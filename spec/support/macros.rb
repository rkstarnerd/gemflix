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