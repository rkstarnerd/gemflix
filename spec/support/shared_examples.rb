shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id]  = nil
    action
    expect(response).to redirect_to signin_path
  end
end

shared_examples "redirects to my_queue_path" do
  it "redirects to the my queue page" do
      set_current_user
      action
      expect(response).to redirect_to my_queue_path
    end
end