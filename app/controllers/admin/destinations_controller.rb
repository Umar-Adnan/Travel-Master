module Admin
  class DestinationsController < BaseController
    before_action :set_destination, only: [:show, :edit, :update, :destroy]

    def index
      @destinations = Destination.order(:name)
    end

    def show
    end

    def new
      @destination = Destination.new(available: true, is_domestic: false, price: 150.0, rating: 4.8)
    end

    def create
      @destination = Destination.new(destination_params)
      if @destination.save
        redirect_to admin_destinations_path, notice: "Destination '#{@destination.name}' created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @destination.update(destination_params)
        redirect_to admin_destinations_path, notice: "Destination '#{@destination.name}' updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @destination.destroy
      redirect_to admin_destinations_path, notice: "Destination deleted."
    end

    private

    def set_destination
      @destination = Destination.find(params[:id])
    end

    def destination_params
      params.require(:destination).permit(:name, :country, :city, :description, :price, :available, :duration, :departure_date, :category, :image_url, :latitude, :longitude, :best_season, :is_domestic, :rating, :popular_attractions)
    end
  end
end
