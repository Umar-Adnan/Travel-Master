module Admin
  class TransportsController < BaseController
    before_action :set_transport, only: [:show, :edit, :update, :destroy]

    def index
      @transports = Transport.includes(:destination).order(:origin_city)
    end

    def show
    end

    def new
      @transport = Transport.new(transport_type: "Flight", seats_available: 30, comfort_class: "Standard", eco_rating: 4.2)
      @destinations = Destination.order(:name)
    end

    def create
      @transport = Transport.new(transport_params)
      if @transport.save
        redirect_to admin_transports_path, notice: "Transport route created successfully."
      else
        @destinations = Destination.order(:name)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @destinations = Destination.order(:name)
    end

    def update
      if @transport.update(transport_params)
        redirect_to admin_transports_path, notice: "Transport route updated successfully."
      else
        @destinations = Destination.order(:name)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @transport.destroy
      redirect_to admin_transports_path, notice: "Transport route deleted."
    end

    private

    def set_transport
      @transport = Transport.find(params[:id])
    end

    def transport_params
      params.require(:transport).permit(:destination_id, :origin_city, :destination_city, :transport_type, :provider_name, :departure_time, :arrival_time, :duration_minutes, :fare_price, :seats_available, :comfort_class, :eco_rating)
    end
  end
end
