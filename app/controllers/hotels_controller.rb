class HotelsController < ApplicationController
  def index
    @hotels = Hotel.all.includes(:destination)

    if params[:q].present?
      @hotels = @hotels.search_by_name(params[:q])
    end

    if params[:destination_id].present?
      @hotels = @hotels.where(destination_id: params[:destination_id])
    end

    if params[:tier] == "budget"
      @hotels = @hotels.budget
    elsif params[:tier] == "mid_range"
      @hotels = @hotels.mid_range
    elsif params[:tier] == "luxury"
      @hotels = @hotels.luxury
    end

    if params[:stars].present?
      @hotels = @hotels.by_stars(params[:stars])
    end

    @destinations = Destination.available.order(:name)
    @user_trips = current_user&.trips&.upcoming || []
  end

  def show
    @hotel = Hotel.find(params[:id])
    @destination = @hotel.destination
    @user_trips = current_user&.trips&.upcoming || []
  end

  def add_to_trip
    authenticate_user!
    hotel = Hotel.find(params[:id])
    trip = current_user.trips.find(params[:trip_id])
    nights = [params[:nights].to_i, 1].max
    rooms = [params[:rooms].to_i, 1].max
    unit_cost = hotel.price_per_night * nights

    trip.trip_bookings.create!(
      bookable: hotel,
      item_type: "hotel",
      title: "#{hotel.name} (#{nights} nights, #{rooms} #{'room'.pluralize(rooms)})",
      unit_cost: unit_cost,
      quantity: rooms,
      total_cost: unit_cost * rooms,
      booking_status: "reserved",
      details: "Address: #{hotel.address}. Star Rating: #{hotel.star_rating}⭐"
    )

    # Ensure destination is linked to trip
    unless trip.destinations.include?(hotel.destination)
      trip.trip_destinations.create(destination: hotel.destination, visit_order: trip.trip_destinations.count + 1, stay_days: nights)
    end

    flash[:notice] = "Added '#{hotel.name}' to trip '#{trip.title}'!"
    redirect_to trip_path(trip)
  end
end
