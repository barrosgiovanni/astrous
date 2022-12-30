class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :astro

  validates :check_in, :check_out, presence: true, uniqueness: true

  # accept or reject the booking request ...
  enum status: { Pending: 0, Confirmed: 1, Rejected: 2 }

  def confirm!
    self.update(status: 1)
  end

  def reject!
    self.update(status: 2)
  end
end
