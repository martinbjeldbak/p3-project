class UserMailer < ActionMailer::Base
  default from: "robot@foodl.dk"

  def create_and_deliver_password_change(user, password)
    @user = user
    @password = password
    mail(to: user.email, subject: "Glemt kodeord på Foodl")
  end
end
