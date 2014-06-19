class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def view
    @user = User.where(id: session[:user_id]).first
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_view_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
