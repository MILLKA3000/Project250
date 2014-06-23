class SessionsController < ApplicationController
  layout "login"
  def new
  end

  def create
    user = User.authenticate(params[:inp_user], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_view_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
