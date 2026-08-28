class TripDestination < ApplicationRecord
  belongs_to :trip
  belongs_to :destination

  validates :visit_order, numericality: { greater_than_or_equal_to: 1 }
  validates :stay_days, numericality: { greater_than_or_equal_to: 1 }
end
