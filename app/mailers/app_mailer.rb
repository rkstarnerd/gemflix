class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@gemflix.com", subject: "Welcome to GemFLiX"
  end
end
