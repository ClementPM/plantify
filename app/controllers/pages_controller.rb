class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @plants = Plant.all.sample(3)
  end

  def dashboard
    @bookings = current_user.bookings
    @plants = current_user.plants
  end
end
