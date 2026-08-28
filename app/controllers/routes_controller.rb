class RoutesController < ApplicationController
  def index
    @routes = RoutesInfo.all.includes(:destination)

    if params[:origin_city].present? || params[:destination_city].present?
      @routes = RoutesInfo.search_between(params[:origin_city], params[:destination_city])
    end

    if params[:road_condition].present?
      @routes = @routes.where(road_condition: params[:road_condition])
    end

    @cities = (RoutesInfo.distinct.pluck(:origin_city) + RoutesInfo.distinct.pluck(:destination_city)).uniq.sort
  end

  def show
    @route = RoutesInfo.find(params[:id])
    @destination = @route.destination
  end
end
