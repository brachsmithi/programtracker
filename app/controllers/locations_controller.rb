class LocationsController < ApplicationController

  def index
    if params[:search]
      p "searching for #{params[:search]}"
      @search = params[:search]
      @search_results_locations = Location.search_name(params[:search]).paginate(page: @page, per_page: 15)
      p @search_results_locations
      respond_to do |format|
        format.html { @locations = @search_results_locations}
        format.js { render partial: 'search-results'}
      end
    else
      @locations = Location.all_by_name.paginate(page: @page, per_page: 15)
    end
  end

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find params[:id]
    @search = params[:search]
  end

  def update
    @location = Location.find params[:id]
    @search = params[:search]
    if @location.update location_params
      redirect_to location_path(@location, page: @page, search: @search)
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
    @search = params[:search]
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
