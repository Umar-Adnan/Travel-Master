class CrowdsController < ApplicationController
  def index
    @destinations = Destination.available.includes(:crowd_forecasts).order(:name)
    @peak_destinations = Destination.joins(:crowd_forecasts).where(crowd_forecasts: { crowd_level: ["High", "Extreme Peak"] }).distinct
    @quiet_destinations = Destination.joins(:crowd_forecasts).where(crowd_forecasts: { crowd_level: "Low" }).distinct
  end

  def show
    @destination = Destination.find(params[:id])
    @forecasts = @destination.crowd_forecasts
    @analysis = CrowdAnalysisService.analyze(@destination, params[:season])
  end
end
