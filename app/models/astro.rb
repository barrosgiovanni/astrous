class Astro < ApplicationRecord
  has_many :bookings

  validates :name, :body_type, :price, presence: true
  validates :name, uniqueness: true
end
