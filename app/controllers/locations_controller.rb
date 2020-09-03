class LocationsController < ApplicationController
  def index
    page = params[:page]
    @locations = Location.all_by_name.paginate(page: params[:page], per_page: 15)
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def update
    page = params[:page]
    @location = Location.find params[:id]
    if @location.update location_params
      redirect_to location_path(@location, page: page)
    else
      @page = page
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
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
