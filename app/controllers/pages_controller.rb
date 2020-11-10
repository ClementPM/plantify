class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @plants = Plant.all.sample(3)
  end

  def dashboard
    @bookings = Booking.where(booking.user = current_user)
    @plants = Plant.where(plant.user = current_user)
  end
end
