class Alert < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :destination, optional: true

  validates :alert_type, presence: true
  validates :title, presence: true
  validates :message, presence: true

  scope :unread, -> { where(is_read: false) }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  def severity_badge_class
    case severity.to_s.downcase
    when "warning" then "badge-warning"
    when "critical" then "badge-critical"
    when "success" then "badge-success"
    else "badge-info"
    end
  end

  def type_icon
    case alert_type.to_s.downcase
    when "weather" then "🌦️"
    when "route" then "🚧"
    when "crowd" then "👥"
    when "price_drop" then "🏷️"
    when "booking" then "📋"
    else "🔔"
    end
  end
end
