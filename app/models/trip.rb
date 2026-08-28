class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_destinations, -> { order(:visit_order) }, dependent: :destroy
  has_many :destinations, through: :trip_destinations
  has_many :trip_bookings, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_travelers, numericality: { greater_than_or_equal_to: 1 }
  validate :end_date_after_start_date

  scope :upcoming, -> { where("start_date >= ?", Date.current).order(start_date: :asc) }
  scope :past, -> { where("end_date < ?", Date.current).order(start_date: :desc) }
  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.current, Date.current) }

  def duration_days
    return 1 unless start_date && end_date
    [(end_date - start_date).to_i + 1, 1].max
  end

  def recalculate_total_cost!
    sum = trip_bookings.sum(:total_cost)
    update_column(:total_estimated_cost, sum)
  end

  def budget_variance
    return 0.0 unless target_budget.present? && target_budget > 0
    (target_budget - total_estimated_cost).to_f
  end

  def budget_status
    return "No Target Set" unless target_budget.present? && target_budget > 0
    if total_estimated_cost <= target_budget
      "Within Budget"
    else
      "Over Budget"
    end
  end

  def cost_breakdown_by_category
    trip_bookings.group(:item_type).sum(:total_cost)
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "must be on or after start date")
    end
  end
end
