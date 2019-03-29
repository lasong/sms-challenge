class Information < ActiveRecord::Base
  STATUSES = %w(Often Never Seldom Weekly Daily Yearly Once Monthly)
  HEX_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/

  validates :city, :start_date, :end_date, presence: true
  validates :price, numericality: true
  validates :status,
            inclusion: { in: STATUSES, message: '%{value} is not a valid status' }
  validates :color,
            format: { with: HEX_REGEX, message: '%{value} is not a hex color code' }
end
