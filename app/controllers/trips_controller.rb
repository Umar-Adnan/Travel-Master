class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy, :itinerary, :cost_breakdown, :auto_estimate, :print_view]

  def index
    @trips = current_user.trips.order(start_date: :asc)
    @upcoming_trips = @trips.upcoming
    @past_trips = @trips.past
  end

  def show
    @destinations = @trip.destinations
    @bookings = @trip.trip_bookings.order(item_type: :asc, date: :asc)
    @breakdown = @trip.cost_breakdown_by_category
    @available_destinations = Destination.available.where.not(id: @destinations.pluck(:id))
    @new_booking = @trip.trip_bookings.build
  end

  def new
    @trip = current_user.trips.build(
      start_date: Date.current + 7.days,
      end_date: Date.current + 12.days,
      number_of_travelers: 1,
      trip_type: "Personal"
    )
    @destinations = Destination.available
  end

  def create
    @trip = current_user.trips.build(trip_params)

    if @trip.save
      # Add selected destinations
      if params[:destination_ids].present?
        params[:destination_ids].reject(&:blank?).each_with_index do |dest_id, index|
          @trip.trip_destinations.create(
            destination_id: dest_id,
            visit_order: index + 1,
            stay_days: [(@trip.duration_days / params[:destination_ids].reject(&:blank?).size.to_f).ceil, 1].max
          )
        end
      end

      # Auto populate initial cost estimation
      estimate = CostEstimationService.estimate(
        destinations: @trip.destinations,
        duration_days: @trip.duration_days,
        travelers: @trip.number_of_travelers,
        travel_tier: current_user.travel_preference || "moderate",
        transport_mode: "flight"
      )
      CostEstimationService.populate_trip_bookings_from_estimate(@trip, estimate)

      # Generate advisories
      NotificationService.generate_trip_advisories(@trip)

      flash[:notice] = "Trip '#{@trip.title}' successfully created with initial cost estimates!"
      redirect_to trip_path(@trip)
    else
      @destinations = Destination.available
      flash.now[:alert] = "Failed to create trip. Please review errors."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @destinations = Destination.available
  end

  def update
    if @trip.update(trip_params)
      if params[:destination_ids].present?
        @trip.trip_destinations.destroy_all
        params[:destination_ids].reject(&:blank?).each_with_index do |dest_id, index|
          @trip.trip_destinations.create(
            destination_id: dest_id,
            visit_order: index + 1,
            stay_days: 1
          )
        end
      end
      flash[:notice] = "Trip updated successfully."
      redirect_to trip_path(@trip)
    else
      @destinations = Destination.available
      flash.now[:alert] = "Failed to update trip."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    flash[:notice] = "Trip deleted."
    redirect_to trips_path
  end

  def itinerary
    @destinations = @trip.destinations
    @bookings = @trip.trip_bookings.order(:date, :item_type)
  end

  def cost_breakdown
    @breakdown = @trip.cost_breakdown_by_category
    @bookings = @trip.trip_bookings.order(item_type: :asc)
  end

  def auto_estimate
    travel_tier = params[:tier].presence || current_user.travel_preference || "moderate"
    transport_mode = params[:transport_mode].presence || "flight"

    estimate = CostEstimationService.estimate(
      destinations: @trip.destinations,
      duration_days: @trip.duration_days,
      travelers: @trip.number_of_travelers,
      travel_tier: travel_tier,
      transport_mode: transport_mode
    )

    CostEstimationService.populate_trip_bookings_from_estimate(@trip, estimate)

    flash[:notice] = "Trip expenses recalculation applied (#{travel_tier.capitalize} tier)!"
    redirect_to trip_path(@trip)
  end

  def print_view
    @destinations = @trip.destinations
    @bookings = @trip.trip_bookings.order(:item_type)
    render layout: "print"
  end

  private

  def set_trip
    @trip = current_user.trips.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:title, :trip_type, :start_date, :end_date, :number_of_travelers, :budget_currency, :target_budget, :notes, :status)
  end
end
