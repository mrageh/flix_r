class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    if user = Session.new(params[:session]).user
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || user),
        notice: "Welcome back, #{user.name}!"
    else
      redirect_to signin_path, notice: 'Invalid password or email address'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'signed out!'
  end
end
