class LocationsController < ApplicationController
  def index
    @locations = Location.all_by_name.paginate(page: params[:page], per_page: 15)
  end

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find params[:id]
  end

  def update
    @location = Location.find params[:id]
    if @location.update location_params
      redirect_to @location
    else
      render "edit"
    end
  end


  def create
    @location = Location.new location_params
    if @location.save
      redirect_to @location
    else
      render "new"
    end
  end

  def show
    @location = Location.find params[:id]
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
