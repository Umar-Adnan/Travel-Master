class CostEstimationService
  # Tier daily allowances per traveler in USD
  FOOD_ALLOWANCE = {
    "budget" => 25.0,
    "moderate" => 55.0,
    "luxury" => 120.0
  }.freeze

  ACTIVITY_ALLOWANCE = {
    "budget" => 15.0,
    "moderate" => 40.0,
    "luxury" => 100.0
  }.freeze

  DEFAULT_HOTEL_TIER = {
    "budget" => 60.0,
    "moderate" => 140.0,
    "luxury" => 320.0
  }.freeze

  def self.estimate(destinations:, duration_days: 3, travelers: 1, travel_tier: "moderate", transport_mode: "flight", origin_city: nil)
    duration_days = [duration_days.to_i, 1].max
    travelers = [travelers.to_i, 1].max
    tier = travel_tier.to_s.downcase
    tier = "moderate" unless %w[budget moderate luxury].include?(tier)

    destinations = Array(destinations).compact

    # 1. Lodging calculation
    total_lodging = 0.0
    destinations.each do |dest|
      hotel = dest.hotels.order(:price_per_night).first
      nightly_rate = if hotel.present?
        tier == "luxury" ? (dest.hotels.order(price_per_night: :desc).first&.price_per_night || DEFAULT_HOTEL_TIER[tier]) : hotel.price_per_night
      else
        (dest.price || DEFAULT_HOTEL_TIER[tier])
      end
      # 1 room for every 2 travelers
      rooms_needed = (travelers / 2.0).ceil
      total_lodging += (nightly_rate * [duration_days - 1, 1].max * rooms_needed).to_f
    end
    total_lodging = (DEFAULT_HOTEL_TIER[tier] * [duration_days - 1, 1].max * (travelers / 2.0).ceil) if destinations.empty?

    # 2. Transport calculation
    total_transport = 0.0
    destinations.each do |dest|
      if origin_city.present?
        matching_transports = Transport.by_route(origin_city, dest.city).by_type(transport_mode.capitalize)
        transport_item = matching_transports.first || Transport.by_route(origin_city, dest.city).first
      else
        transport_item = dest.transports.first
      end

      unit_fare = if transport_item.present?
        transport_item.fare_price.to_f
      else
        case transport_mode.downcase
        when "flight" then 220.0
        when "train" then 75.0
        when "bus" then 35.0
        when "car rental", "rental" then (45.0 * duration_days) / travelers # per person
        else 150.0
        end
      end
      total_transport += (unit_fare * travelers)
    end
    total_transport = (180.0 * travelers) if destinations.empty?

    # 3. Food and Dining calculation
    daily_food = FOOD_ALLOWANCE[tier] || 50.0
    total_food = daily_food * duration_days * travelers

    # 4. Activities & Sightseeing
    daily_activity = ACTIVITY_ALLOWANCE[tier] || 35.0
    total_activities = daily_activity * duration_days * travelers

    # 5. Tolls & Fuel estimation
    total_fuel_tolls = 0.0
    destinations.each do |dest|
      if origin_city.present?
        route = RoutesInfo.search_between(origin_city, dest.city).first
        if route.present?
          total_fuel_tolls += route.total_estimated_road_cost.to_f
        else
          total_fuel_tolls += 45.0
        end
      end
    end
    total_fuel_tolls = 30.0 if total_fuel_tolls == 0.0

    # 6. Contingency / Misc Buffer (8%)
    subtotal = total_lodging + total_transport + total_food + total_activities + total_fuel_tolls
    contingency = (subtotal * 0.08).round(2)
    grand_total = (subtotal + contingency).round(2)
    per_person = (grand_total / travelers).round(2)

    {
      grand_total: grand_total,
      per_person: per_person,
      duration_days: duration_days,
      travelers: travelers,
      tier: tier,
      breakdown: {
        lodging: total_lodging.round(2),
        transport: total_transport.round(2),
        food: total_food.round(2),
        activities: total_activities.round(2),
        fuel_and_tolls: total_fuel_tolls.round(2),
        contingency_buffer: contingency
      }
    }
  end

  def self.populate_trip_bookings_from_estimate(trip, estimate_result)
    return unless trip.present? && estimate_result.present?

    # Clear existing estimated items if any
    trip.trip_bookings.where(booking_status: "estimated").destroy_all

    breakdown = estimate_result[:breakdown] || {}

    trip.trip_bookings.create!(
      item_type: "hotel",
      title: "Estimated Accommodations (#{trip.duration_days} nights)",
      unit_cost: (breakdown[:lodging].to_f / [trip.duration_days, 1].max).round(2),
      quantity: [trip.duration_days, 1].max,
      total_cost: breakdown[:lodging].to_f,
      booking_status: "estimated"
    )

    trip.trip_bookings.create!(
      item_type: "transport",
      title: "Estimated Transportation (#{trip.number_of_travelers} travelers)",
      unit_cost: (breakdown[:transport].to_f / [trip.number_of_travelers, 1].max).round(2),
      quantity: [trip.number_of_travelers, 1].max,
      total_cost: breakdown[:transport].to_f,
      booking_status: "estimated"
    )

    trip.trip_bookings.create!(
      item_type: "food",
      title: "Estimated Dining & Meals (#{trip.duration_days} days)",
      unit_cost: (breakdown[:food].to_f / [trip.duration_days, 1].max).round(2),
      quantity: [trip.duration_days, 1].max,
      total_cost: breakdown[:food].to_f,
      booking_status: "estimated"
    )

    trip.trip_bookings.create!(
      item_type: "activity",
      title: "Estimated Sightseeing & Activities",
      unit_cost: breakdown[:activities].to_f,
      quantity: 1,
      total_cost: breakdown[:activities].to_f,
      booking_status: "estimated"
    )

    trip.trip_bookings.create!(
      item_type: "toll_fuel",
      title: "Estimated Tolls, Transfers & Fuel",
      unit_cost: breakdown[:fuel_and_tolls].to_f,
      quantity: 1,
      total_cost: breakdown[:fuel_and_tolls].to_f,
      booking_status: "estimated"
    )

    trip.recalculate_total_cost!
  end
end
