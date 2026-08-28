class Hotel < ApplicationRecord
  belongs_to :destination
  has_many :trip_bookings, as: :bookable, dependent: :nullify

  validates :name, presence: true
  validates :price_per_night, presence: true, numericality: { greater_than: 0 }
  validates :star_rating, inclusion: { in: 1..5 }

  scope :budget, -> { where("price_per_night <= 100") }
  scope :mid_range, -> { where("price_per_night > 100 AND price_per_night <= 250") }
  scope :luxury, -> { where("price_per_night > 250") }
  scope :by_stars, ->(stars) { where(star_rating: stars) if stars.present? }
  scope :search_by_name, ->(q) { where("LOWER(name) LIKE ?", "%#{q.downcase}%") if q.present? }

  def amenities_list
    return [] if amenities.blank?
    amenities.split(",").map(&:strip)
  end

  def budget_tier
    if price_per_night <= 100
      "Budget"
    elsif price_per_night <= 250
      "Mid-Range"
    else
      "Luxury"
    end
  end
end
