module Admin
  class AlertsController < BaseController
    before_action :set_alert, only: [:destroy]

    def index
      @alerts = Alert.order(created_at: :desc)
    end

    def new
      @alert = Alert.new(severity: "info", alert_type: "weather")
      @destinations = Destination.order(:name)
      @users = User.order(:name)
    end

    def create
      @alert = Alert.new(alert_params)
      if @alert.save
        redirect_to admin_alerts_path, notice: "System alert broadcasted successfully."
      else
        @destinations = Destination.order(:name)
        @users = User.order(:name)
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @alert.destroy
      redirect_to admin_alerts_path, notice: "Alert deleted."
    end

    private

    def set_alert
      @alert = Alert.find(params[:id])
    end

    def alert_params
      params.require(:alert).permit(:user_id, :destination_id, :alert_type, :title, :message, :severity, :is_read)
    end
  end
end
