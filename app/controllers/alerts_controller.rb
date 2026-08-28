class AlertsController < ApplicationController
  before_action :authenticate_user!

  def index
    @alerts = Alert.where("user_id = ? OR user_id IS NULL", current_user.id).order(created_at: :desc)
    @unread_count = @alerts.where(is_read: false).count
  end

  def update
    @alert = Alert.find(params[:id])
    @alert.update(is_read: true)
    respond_to do |format|
      format.html { redirect_to alerts_path, notice: "Alert marked as read." }
      format.json { head :ok }
    end
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    redirect_to alerts_path, notice: "Alert dismissed."
  end

  def mark_all_read
    Alert.where("user_id = ? OR user_id IS NULL", current_user.id).update_all(is_read: true)
    redirect_to alerts_path, notice: "All alerts marked as read."
  end
end
