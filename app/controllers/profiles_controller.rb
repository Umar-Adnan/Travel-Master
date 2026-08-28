class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @trips = @user.trips.order(start_date: :asc)
    @recent_alerts = Alert.where("user_id = ? OR user_id IS NULL", @user.id).recent
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      flash[:notice] = "Your profile has been updated."
      redirect_to profile_path
    else
      flash.now[:alert] = "Failed to update profile."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :phone_number, :travel_preference, :default_currency, :bio, :avatar_url)
  end
end
