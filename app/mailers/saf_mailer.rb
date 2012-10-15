class SafMailer < ActionMailer::Base
  default from: "saf.proj2.6170@gmail.com"
  
  def welcome_email(user)
    @user = user
    @url = "powerful-scrubland-1233.herokuapp.com/welcome"
    mail(:to => user.email, :subject => "Welcome to SAFPROJ2.")
  end
  
  def checkout(user)
    @user = user
    mail(:to => @user.email, :subject => "SAFPROJ2 checkout confirmation")
  end
  
  def share_wl(url,addr,user)
    @url = "powerful-scrubland-1233.herokuapp.com" + url.to_s
    @user = user
    sub = "" + @user.email.to_s + " has sent you a wishlist"
    mail(:to => addr, :subject => sub)
  end
end
