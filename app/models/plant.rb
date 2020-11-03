class Plant < ApplicationRecord
  validates :name, presence: true
  belongs_to :users
  has_one_attached :photo
end
