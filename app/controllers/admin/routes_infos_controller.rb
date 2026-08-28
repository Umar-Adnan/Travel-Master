module Admin
  class RoutesInfosController < BaseController
    before_action :set_route_info, only: [:show, :edit, :update, :destroy]

    def index
      @routes = RoutesInfo.includes(:destination).order(:origin_city)
    end

    def show
    end

    def new
      @route = RoutesInfo.new(road_condition: "Good", scenic_score: 4, traffic_level: "Light")
      @destinations = Destination.order(:name)
    end

    def create
      @route = RoutesInfo.new(route_params)
      if @route.save
        redirect_to admin_routes_infos_path, notice: "Route segment created successfully."
      else
        @destinations = Destination.order(:name)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @destinations = Destination.order(:name)
    end

    def update
      if @route.update(route_params)
        redirect_to admin_routes_infos_path, notice: "Route segment updated successfully."
      else
        @destinations = Destination.order(:name)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @route.destroy
      redirect_to admin_routes_infos_path, notice: "Route segment deleted."
    end

    private

    def set_route_info
      @route = RoutesInfo.find(params[:id])
    end

    def route_params
      params.require(:routes_info).permit(:destination_id, :origin_city, :destination_city, :route_name, :distance_km, :estimated_drive_time_hours, :road_condition, :toll_charges, :scenic_score, :traffic_level, :route_highlights)
    end
  end
end
