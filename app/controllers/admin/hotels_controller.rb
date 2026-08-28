module Admin
  class HotelsController < BaseController
    before_action :set_hotel, only: [:show, :edit, :update, :destroy]

    def index
      @hotels = Hotel.includes(:destination).order(:name)
    end

    def show
    end

    def new
      @hotel = Hotel.new(star_rating: 4, available_rooms: 15, hotel_type: "Hotel")
      @destinations = Destination.order(:name)
    end

    def create
      @hotel = Hotel.new(hotel_params)
      if @hotel.save
        redirect_to admin_hotels_path, notice: "Hotel '#{@hotel.name}' created successfully."
      else
        @destinations = Destination.order(:name)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @destinations = Destination.order(:name)
    end

    def update
      if @hotel.update(hotel_params)
        redirect_to admin_hotels_path, notice: "Hotel '#{@hotel.name}' updated successfully."
      else
        @destinations = Destination.order(:name)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @hotel.destroy
      redirect_to admin_hotels_path, notice: "Hotel deleted."
    end

    private

    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    def hotel_params
      params.require(:hotel).permit(:destination_id, :name, :hotel_type, :address, :star_rating, :price_per_night, :available_rooms, :amenities, :image_url, :description, :contact_number)
    end
  end
end
