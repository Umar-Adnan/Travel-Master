module Admin
  class DashboardController < BaseController
    def index
      @total_users = User.count
      @total_destinations = Destination.count
      @total_trips = Trip.count
      @total_hotels = Hotel.count
      @total_transports = Transport.count
      @total_routes = RoutesInfo.count
      @recent_trips = Trip.order(created_at: :desc).limit(5)
      @recent_users = User.order(created_at: :desc).limit(5)
      @active_alerts = Alert.recent.limit(5)
    end
  end
end
