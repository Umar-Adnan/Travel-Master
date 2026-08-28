class Destination < ApplicationRecord
  has_many :trip_destinations, dependent: :destroy
  has_many :trips, through: :trip_destinations
  has_many :hotels, dependent: :destroy
  has_many :transports, dependent: :nullify
  has_many :routes_infos, dependent: :nullify
  has_many :weather_forecasts, dependent: :destroy
  has_many :crowd_forecasts, dependent: :destroy
  has_many :alerts, dependent: :nullify

  validates :name, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where(available: true) }
  scope :domestic, -> { where(is_domestic: true) }
  scope :international, -> { where(is_domestic: false) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }
  scope :by_max_budget, ->(max) { where("price <= ?", max) if max.present? }
  scope :search_by_keyword, ->(query) {
    if query.present?
      q = "%#{query.downcase}%"
      where("LOWER(name) LIKE ? OR LOWER(city) LIKE ? OR LOWER(country) LIKE ? OR LOWER(description) LIKE ?", q, q, q, q)
    end
  }

  def current_weather
    weather_forecasts.order(forecast_date: :asc).first
  end

  def current_crowd
    crowd_forecasts.first
  end

  def base_daily_cost
    price || 100.0
  end

  def attractions_list
    return [] if popular_attractions.blank?
    popular_attractions.split(",").map(&:strip)
  end
end
