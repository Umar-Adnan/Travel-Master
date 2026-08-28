class CrowdAnalysisService
  def self.analyze(destination, month_or_season = nil)
    return default_crowd_data unless destination

    forecast = if month_or_season.present?
      destination.crowd_forecasts.find_by("LOWER(month_or_season) = ?", month_or_season.downcase) || destination.crowd_forecasts.first
    else
      destination.crowd_forecasts.first
    end

    return default_crowd_data unless forecast

    {
      level: forecast.crowd_level,
      percentage: forecast.intensity_percentage,
      season_type: forecast.season_type,
      occupancy: forecast.average_hotel_occupancy,
      recommendations: forecast.recommendations.presence || "Book popular attraction tickets at least 2 weeks in advance.",
      best_time_advice: best_time_tip(forecast.season_type, forecast.crowd_level)
    }
  end

  def self.best_time_tip(season_type, crowd_level)
    case crowd_level.to_s.downcase
    when "extreme peak", "high"
      "Consider visiting early in the morning or during shoulder seasons for 20-30% lower accommodation prices."
    when "low"
      "Great time for budget travelers! Low wait times at attractions and high hotel availability."
    else
      "Balanced crowd levels. Good availability with moderate pricing across services."
    end
  end

  private

  def self.default_crowd_data
    {
      level: "Moderate",
      percentage: 50,
      season_type: "Shoulder-Season",
      occupancy: 65,
      recommendations: "Advance booking is recommended for popular sightseeing spots.",
      best_time_advice: "Plan visits during mid-week to avoid peak weekend crowds."
    }
  end
end
