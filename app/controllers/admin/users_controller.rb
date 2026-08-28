module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.order(created_at: :desc)
    end

    def show
      @trips = @user.trips
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User '#{@user.name}' updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot delete your own account from admin portal."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role, :phone_number, :travel_preference, :default_currency)
    end
  end
end
