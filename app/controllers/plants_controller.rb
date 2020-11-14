class PlantsController < ApplicationController
  def index
    @plants = Plant.all

    @plants = @plants.where("name ILIKE ?", "%#{params[:query]}%") if params[:query]

    @plants = @plants.where(category: params[:category]) if params[:category]

    @markers = @plants.map do |plant|
      {
        lat: plant.latitude,
        lng: plant.longitude
      }
    end
  end

  def show
    @plant = Plant.find(params[:id])
    @booking = Booking.new
    @markers = [{
      lat: @plant.latitude,
      lng: @plant.longitude
    }]
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user
    if @plant.save
      redirect_to plant_path(@plant)
    else
      render :new
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :description, :category, :price, :address, photos: [])
  end
end
