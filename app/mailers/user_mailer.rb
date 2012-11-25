class UserMailer < ActionMailer::Base
  default :from => "syutran@gmail.com"

  def confirm(email,subject,message)
    mail(:to => email, :subject => subject, :body => message)
  end
end
