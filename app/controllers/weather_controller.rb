class WeatherController < ApplicationController
  def index
    @destinations = Destination.available.includes(:weather_forecasts).order(:name)
    @severe_advisories = WeatherForecast.where(advisory_level: ["Advisory", "Severe Warning"]).includes(:destination)
  end

  def show
    @destination = Destination.find(params[:id])
    @forecasts = WeatherService.forecast_for(@destination)
    @advice = WeatherService.travel_recommendations_for(@destination)
  end
end
