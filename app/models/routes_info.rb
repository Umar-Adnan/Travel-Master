class RoutesInfo < ApplicationRecord
  belongs_to :destination, optional: true

  validates :origin_city, presence: true
  validates :destination_city, presence: true
  validates :route_name, presence: true
  validates :distance_km, presence: true, numericality: { greater_than: 0 }

  scope :search_between, ->(orig, dest) {
    s = all
    s = s.where("LOWER(origin_city) LIKE ?", "%#{orig.downcase}%") if orig.present?
    s = s.where("LOWER(destination_city) LIKE ?", "%#{dest.downcase}%") if dest.present?
    s
  }

  def formatted_drive_time
    return "N/A" unless estimated_drive_time_hours.present?
    hours = estimated_drive_time_hours.floor
    mins = ((estimated_drive_time_hours - hours) * 60).round
    "#{hours}h #{mins}m"
  end

  def estimated_fuel_cost(liters_per_100km: 8.5, price_per_liter: 1.5)
    liters_needed = (distance_km / 100.0) * liters_per_100km
    (liters_needed * price_per_liter).round(2)
  end

  def total_estimated_road_cost
    (toll_charges || 0.0) + estimated_fuel_cost
  end
end
