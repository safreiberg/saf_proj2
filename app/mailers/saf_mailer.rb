class SafMailer < ActionMailer::Base
  default from: "saf.proj2.6170@gmail.com"
  
  def welcome_email(user)
    @user = user
    @url = "powerful-scrubland-1233.herokuapp.com/welcome"
    mail(:to => user.email, :subject => "Welcome to SAFPROJ2.")
  end
  
  def checkout(uid)
    @user = User.find_by_id(uid)
    mail(:to => @user.email, :subject => "SAFPROJ2 checkout confirmation")
  end
end
