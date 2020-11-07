class Booking < ApplicationRecord
  belongs_to :plants
  belongs_to :users
  validates :start_date, :end_date, presence: true
end
