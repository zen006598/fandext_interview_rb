class SendWelcomeMailMailer < ApplicationMailer
  def welcome_email(user)
    mail to:user.email, subject:"Welcome to fandnext"
  end
end
