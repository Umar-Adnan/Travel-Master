class CrowdForecast < ApplicationRecord
  belongs_to :destination

  validates :month_or_season, presence: true
  validates :intensity_percentage, inclusion: { in: 0..100 }

  scope :peak_seasons, -> { where(crowd_level: ["High", "Extreme Peak"]) }
  scope :quiet_seasons, -> { where(crowd_level: ["Low", "Moderate"]) }

  def crowd_badge_color
    case crowd_level.to_s.downcase
    when "low" then "bg-emerald-100 text-emerald-800 border-emerald-300"
    when "moderate" then "bg-amber-100 text-amber-800 border-amber-300"
    when "high" then "bg-orange-100 text-orange-800 border-orange-300"
    when "extreme peak" then "bg-red-100 text-red-800 border-red-300"
    else "bg-slate-100 text-slate-800 border-slate-300"
    end
  end

  def crowd_icon
    case crowd_level.to_s.downcase
    when "low" then "🟢 Relaxed"
    when "moderate" then "🟡 Moderate"
    when "high" then "🟠 Crowded"
    when "extreme peak" then "🔴 Very Busy"
    else "⚪ Normal"
    end
  end
end
