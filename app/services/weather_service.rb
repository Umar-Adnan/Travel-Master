class WeatherService
  def self.forecast_for(destination)
    return [] unless destination
    destination.weather_forecasts.order(forecast_date: :asc).limit(7)
  end

  def self.travel_recommendations_for(destination)
    forecasts = forecast_for(destination)
    return "Check local forecasts prior to departure." if forecasts.empty?

    avg_temp = forecasts.sum(&:temperature_celsius) / forecasts.size
    max_rain = forecasts.map(&:rainfall_prob).max || 0

    tips = []
    if avg_temp < 10
      tips << "🧥 Cool temperatures expected (~#{avg_temp.round}°C). Bring warm layers and a heavy jacket."
    elsif avg_temp > 28
      tips << "☀️ High temperatures (~#{avg_temp.round}°C). Pack breathable fabrics, sunscreen, and stay hydrated."
    else
      tips << "🌤️ Pleasant weather expected (~#{avg_temp.round}°C). Ideal for outdoor sightseeing."
    end

    if max_rain > 50
      tips << "☔ High chance of precipitation (#{max_rain}%). An umbrella and waterproof footwear are recommended."
    elsif max_rain > 25
      tips << "🌦️ Scattered light rain possible. Carry a light rain jacket."
    end

    tips.join(" ")
  end
end
