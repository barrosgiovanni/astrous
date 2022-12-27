class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :astro

  validates :check_in, :check_out, presence: true, uniqueness: true
end
