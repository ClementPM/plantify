class BookingsController < ApplicationController

  def create
    @plant = Plant.find(params[:plant_id])
    @booking = Booking.new(booking_params)
    @booking.status = "pending"
    @booking.plant = @plant
    @booking.user = current_user
    if @booking.save
      redirect_to root_path
    else
      render "plants/show"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
