class Astro < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_astros, against: [:name, :body_type, :around_planet, :discovered_by]

  validates :name, :body_type, :price, presence: true
  validates :name, uniqueness: true
end
