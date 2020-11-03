class Plant < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many_attached :photos
end
