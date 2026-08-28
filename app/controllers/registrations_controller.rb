class RegistrationsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = "user"
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to TravelMaster, #{@user.name}! Your account is ready."
      redirect_to profile_path
    else
      flash.now[:alert] = "Please fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :travel_preference, :default_currency, :bio)
  end
end
