class Mailer < ActionMailer::Base
	default to: "woojinp@gmail.com"

  def form_email(from, subject, body)
  	@body = body
  	mail(:from => from, :subject => subject)
	end
end
