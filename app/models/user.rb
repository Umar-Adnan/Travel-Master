class User < ApplicationRecord
  has_secure_password

  has_many :trips, dependent: :destroy
  has_many :alerts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email format" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :role, inclusion: { in: %w[user admin] }

  def admin?
    role == "admin"
  end

  def formatted_preferences
    travel_preference.presence || "Budget-conscious"
  end
end
