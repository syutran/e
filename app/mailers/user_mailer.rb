class UserMailer < ActionMailer::Base
  default :from => "syutran@gmail.com"

  def confirm(email)
    @greeting = "Hi"
    @message = "Thank you for confirmation!"
    mail(:to => email, :subject => @greeting)
  end
end
