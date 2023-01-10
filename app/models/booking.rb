class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :astro

  validates :check_in, :check_out, presence: true, uniqueness: true
  validates :status, presence: true

  # accept or reject the booking request ...
  validates :status, inclusion: { in: ["Pending guest request", "Pending confirmation", "Confirmed", "Canceled"], allow_nil: true }
end
