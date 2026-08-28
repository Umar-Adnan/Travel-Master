class NotificationService
  def self.create_system_alert(title:, message:, alert_type: "info", severity: "info", destination: nil, user: nil)
    Alert.create!(
      user: user,
      destination: destination,
      alert_type: alert_type,
      title: title,
      message: message,
      severity: severity,
      is_read: false
    )
  end

  def self.generate_trip_advisories(trip)
    return unless trip.present?

    trip.destinations.each do |dest|
      # Weather check
      weather = dest.current_weather
      if weather.present? && weather.rainfall_prob > 60
        create_system_alert(
          user: trip.user,
          destination: dest,
          alert_type: "weather",
          title: "Rain Advisory for #{dest.name}",
          message: "High probability of rain (#{weather.rainfall_prob}%) during your travel window. Pack waterproof gear!",
          severity: "warning"
        )
      end

      # Crowd check
      crowd = dest.current_crowd
      if crowd.present? && crowd.intensity_percentage > 80
        create_system_alert(
          user: trip.user,
          destination: dest,
          alert_type: "crowd",
          title: "Peak Tourist Rush at #{dest.name}",
          message: "#{dest.name} is experiencing peak tourist arrivals (#{crowd.intensity_percentage}% capacity). Reserve tickets early.",
          severity: "warning"
        )
      end
    end
  end
end
