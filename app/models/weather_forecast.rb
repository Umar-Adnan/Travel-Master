class WeatherForecast < ApplicationRecord
  belongs_to :destination

  validates :forecast_date, presence: true
  validates :temperature_celsius, presence: true

  scope :for_today, -> { where(forecast_date: Date.current) }
  scope :upcoming_week, -> { where("forecast_date >= ?", Date.current).order(forecast_date: :asc).limit(7) }

  def condition_icon
    cond = condition.to_s.downcase
    if cond.include?("thunder") || cond.include?("storm")
      "⛈️"
    elsif cond.include?("snow")
      "❄️"
    elsif cond.include?("rain") || cond.include?("shower") || cond.include?("drizzle")
      "🌧️"
    elsif cond.include?("sunny") || cond.include?("tropical sunshine")
      "☀️"
    elsif cond.include?("partly cloudy") || cond.include?("scattered")
      "⛅"
    elsif cond.include?("cloudy") || cond.include?("overcast")
      "☁️"
    elsif cond.include?("clear") || cond.include?("mountain")
      "🌤️"
    elsif cond.include?("wind")
      "💨"
    else
      "🌤️"
    end
  end

  def temperature_fahrenheit
    ((temperature_celsius * 9.0 / 5.0) + 32).round(1)
  end
end
