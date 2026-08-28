class Transport < ApplicationRecord
  belongs_to :destination, optional: true
  has_many :trip_bookings, as: :bookable, dependent: :nullify

  validates :origin_city, presence: true
  validates :destination_city, presence: true
  validates :transport_type, presence: true
  validates :fare_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :flights, -> { where(transport_type: "Flight") }
  scope :trains, -> { where(transport_type: "Train") }
  scope :buses, -> { where(transport_type: "Bus") }
  scope :rentals, -> { where(transport_type: "Car Rental") }
  scope :by_type, ->(t) { where(transport_type: t) if t.present? }
  scope :by_route, ->(orig, dest) {
    s = all
    s = s.where("LOWER(origin_city) LIKE ?", "%#{orig.downcase}%") if orig.present?
    s = s.where("LOWER(destination_city) LIKE ?", "%#{dest.downcase}%") if dest.present?
    s
  }

  def duration_formatted
    return "N/A" unless duration_minutes.present? && duration_minutes > 0
    hours = duration_minutes / 60
    mins = duration_minutes % 60
    if hours > 0
      "#{hours}h #{mins}m"
    else
      "#{mins}m"
    end
  end

  def type_icon
    case transport_type.to_s.downcase
    when "flight" then "✈️"
    when "train" then "🚆"
    when "bus" then "🚌"
    when "car rental", "rental" then "🚗"
    when "private transfer" then "🚐"
    else "🧳"
    end
  end
end
