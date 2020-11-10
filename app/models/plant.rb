class Plant < ApplicationRecord
  geocoded_by :address
  validates :name, presence: true
  validates :address, presence: true
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  after_validation :geocode, if: :will_save_change_to_address?
end
