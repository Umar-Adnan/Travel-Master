class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?, :unread_alerts_count

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user!
    unless logged_in?
      flash[:alert] = "Please log in to continue."
      redirect_to login_path
    end
  end

  def require_admin!
    authenticate_user!
    unless current_user&.admin?
      flash[:alert] = "Access restricted to administrators."
      redirect_to root_path
    end
  end

  def unread_alerts_count
    return 0 unless logged_in?
    Alert.where("user_id = ? OR user_id IS NULL", current_user.id).unread.count
  end
end
