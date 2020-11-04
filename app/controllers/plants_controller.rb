class PlantsController < ApplicationController
  def index
    if params[:query]
      @plants = Plant.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @plants = Plant.all
    end
  end

  def show
    @plant = Plant.find(params[:id])
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
    params.require(:plant).permit(:name, :description, :category, :price, photos: [])
  end
end
