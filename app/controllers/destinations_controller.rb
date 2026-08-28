class DestinationsController < ApplicationController
  def index
    @destinations = Destination.available

    if params[:q].present?
      @destinations = @destinations.search_by_keyword(params[:q])
    end

    if params[:category].present?
      @destinations = @destinations.by_category(params[:category])
    end

    if params[:type] == "domestic"
      @destinations = @destinations.domestic
    elsif params[:type] == "international"
      @destinations = @destinations.international
    end

    if params[:max_budget].present?
      @destinations = @destinations.by_max_budget(params[:max_budget])
    end

    @categories = Destination.distinct.pluck(:category).compact
    @countries = Destination.distinct.pluck(:country).compact.sort
  end

  def show
    @destination = Destination.find(params[:id])
    @forecasts = WeatherService.forecast_for(@destination)
    @weather_advice = WeatherService.travel_recommendations_for(@destination)
    @crowd_analysis = CrowdAnalysisService.analyze(@destination)
    @hotels = @destination.hotels.order(:price_per_night)
    @transports = @destination.transports
    @routes = RoutesInfo.where(destination_id: @destination.id).or(RoutesInfo.where("LOWER(destination_city) LIKE ?", "%#{@destination.city.downcase}%"))
    @user_trips = current_user&.trips&.upcoming || []
  end
end
