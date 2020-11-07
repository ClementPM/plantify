class PlantsController < ApplicationController
  def index
    if params[:query]
      @plants = Plant.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @plants = Plant.all
      @plants.each do |plant|
        @markers = [{
          lat: plant.latitude,
          lng: plant.longitude
        }]
      end
    end
  end

  def show
    @plant = Plant.find(params[:id])
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
