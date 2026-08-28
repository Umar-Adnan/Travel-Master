class TransportsController < ApplicationController
  def index
    @transports = Transport.all.includes(:destination)

    if params[:transport_type].present?
      @transports = @transports.by_type(params[:transport_type])
    end

    if params[:origin_city].present? || params[:destination_city].present?
      @transports = @transports.by_route(params[:origin_city], params[:destination_city])
    end

    @transport_types = Transport.distinct.pluck(:transport_type).compact
    @user_trips = current_user&.trips&.upcoming || []
  end

  def show
    @transport = Transport.find(params[:id])
    @user_trips = current_user&.trips&.upcoming || []
  end

  def add_to_trip
    authenticate_user!
    transport = Transport.find(params[:id])
    trip = current_user.trips.find(params[:trip_id])
    travelers = [params[:travelers].to_i, trip.number_of_travelers, 1].max
    unit_cost = transport.fare_price

    trip.trip_bookings.create!(
      bookable: transport,
      item_type: "transport",
      title: "#{transport.transport_type} via #{transport.provider_name} (#{transport.origin_city} → #{transport.destination_city})",
      unit_cost: unit_cost,
      quantity: travelers,
      total_cost: unit_cost * travelers,
      booking_status: "reserved",
      details: "Departure: #{transport.departure_time}, Duration: #{transport.duration_formatted}, Class: #{transport.comfort_class}"
    )

    flash[:notice] = "Added #{transport.transport_type} booking to trip '#{trip.title}'!"
    redirect_to trip_path(trip)
  end
end
