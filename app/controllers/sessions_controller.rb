class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
   if user && user.authenticate(params[:session][:password])
    if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      message = "Tai khoan chua kich hoat. Kiem tra dia chi email de lay link kich hoat"
      flash[:warning] = message
      redirect_to root_url
    end
    else
      flash.now[:danger] = "Email khong chinh xac/password khong trung nhau"
      render 'new'
    end
  end

  def destroy
    log_out
    # log_out if logged_in?
    redirect_to help_path
  end
end
