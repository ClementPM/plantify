class Booking < ApplicationRecord
  belongs_to :plants, :users
  validates :start_date, :end_date, presence: true
end
