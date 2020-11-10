class RenamePlantReferenceInBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :plants_id
    add_reference :bookings, :plant, foreign_key: true
  end
end
