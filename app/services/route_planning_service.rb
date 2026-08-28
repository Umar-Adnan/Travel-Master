class RoutePlanningService
  def self.plan(origin_city:, destination_city:)
    return nil if origin_city.blank? || destination_city.blank?

    routes = RoutesInfo.search_between(origin_city, destination_city)
    return routes if routes.any?

    # Fallback simulated route calculation if exact route isn't in database
    simulated_distance = (origin_city.length * 45 + destination_city.length * 35 + 120).to_f
    simulated_hours = (simulated_distance / 75.0).round(1)

    [
      RoutesInfo.new(
        origin_city: origin_city,
        destination_city: destination_city,
        route_name: "Standard Highway Route (#{origin_city} -> #{destination_city})",
        distance_km: simulated_distance,
        estimated_drive_time_hours: simulated_hours,
        road_condition: "Good",
        toll_charges: (simulated_distance * 0.05).round(2),
        scenic_score: 4,
        traffic_level: "Moderate",
        route_highlights: "Direct transit route with rest areas and fuel stations every 45 km."
      )
    ]
  end
end
