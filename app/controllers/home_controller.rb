class HomeController < ApplicationController
  def index
    @featured_destinations = Destination.available.limit(6)
    @categories = Destination.distinct.pluck(:category).compact
    @popular_routes = RoutesInfo.limit(4)
    @latest_alerts = Alert.recent.limit(3)
    @all_destinations = Destination.available.order(:name)
  end
end
