class CostEstimatorsController < ApplicationController
  def index
    @destinations = Destination.available.order(:name)
    @selected_destination_ids = params[:destination_ids] || []
    @selected_destinations = Destination.where(id: @selected_destination_ids)
    @duration_days = (params[:duration_days] || 5).to_i
    @travelers = (params[:travelers] || 2).to_i
    @travel_tier = params[:travel_tier] || (current_user&.travel_preference || "moderate")
    @transport_mode = params[:transport_mode] || "flight"
    @origin_city = params[:origin_city] || "New York"

    @estimate_result = CostEstimationService.estimate(
      destinations: @selected_destinations,
      duration_days: @duration_days,
      travelers: @travelers,
      travel_tier: @travel_tier,
      transport_mode: @transport_mode,
      origin_city: @origin_city
    )
  end

  def create
    authenticate_user!
    dest_ids = params[:destination_ids] || []
    destinations = Destination.where(id: dest_ids)
    duration_days = (params[:duration_days] || 5).to_i
    travelers = (params[:travelers] || 1).to_i
    tier = params[:travel_tier] || "moderate"
    transport_mode = params[:transport_mode] || "flight"

    trip_title = if destinations.any?
      "Trip to #{destinations.map(&:name).to_sentence}"
    else
      "Custom Planned Vacation"
    end

    trip = current_user.trips.create!(
      title: trip_title,
      trip_type: "Personal",
      start_date: Date.current + 14.days,
      end_date: Date.current + 14.days + (duration_days - 1).days,
      number_of_travelers: travelers,
      budget_currency: "USD"
    )

    destinations.each_with_index do |d, i|
      trip.trip_destinations.create!(destination: d, visit_order: i + 1, stay_days: [(duration_days / destinations.size.to_f).ceil, 1].max)
    end

    estimate = CostEstimationService.estimate(
      destinations: destinations,
      duration_days: duration_days,
      travelers: travelers,
      travel_tier: tier,
      transport_mode: transport_mode
    )

    CostEstimationService.populate_trip_bookings_from_estimate(trip, estimate)
    NotificationService.generate_trip_advisories(trip)

    flash[:notice] = "Trip '#{trip.title}' generated directly from Cost Estimator!"
    redirect_to trip_path(trip)
  end
end
