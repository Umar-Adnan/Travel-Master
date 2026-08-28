class TripBooking < ApplicationRecord
  belongs_to :trip
  belongs_to :bookable, polymorphic: true, optional: true

  validates :item_type, presence: true
  validates :title, presence: true
  validates :unit_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  before_save :compute_total_cost
  after_save :trigger_trip_recalculation
  after_destroy :trigger_trip_recalculation

  def category_label
    case item_type
    when "hotel" then "🏨 Hotel & Stay"
    when "transport" then "🚗 Transport & Travel"
    when "food" then "🍽️ Food & Dining"
    when "toll_fuel" then "⛽ Fuel & Tolls"
    when "activity" then "🎟️ Activity & Sightseeing"
    else "📦 Other Expense"
    end
  end

  private

  def compute_total_cost
    self.total_cost = (unit_cost || 0.0) * (quantity || 1)
  end

  def trigger_trip_recalculation
    trip.recalculate_total_cost! if trip
  end
end
