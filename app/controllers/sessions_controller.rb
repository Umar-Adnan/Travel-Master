class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email]&.strip&.downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to profile_path
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end
