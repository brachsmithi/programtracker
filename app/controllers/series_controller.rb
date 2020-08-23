class SeriesController < ApplicationController
  def index
    @series = Series.all_sort_by_name.paginate(page: params[:page], per_page: 15)
  end

  def show
    @series = Series.find params[:id]
  end

  def new
    @series = Series.new
  end

  def create
    @series = Series.new series_params
    if @series.save
      redirect_to @series
    else
      render "new"
    end
  end

  def edit
    @series = Series.find params[:id]
  end

  def update
    @series = Series.find params[:id]
    if @series.update series_params
      redirect_to @series
    else
      render "edit"
    end
  end

  private

  def series_params
    params.require(:series).permit(:name, series_programs_attributes:[:id, :sequence, :series_id, :program_id])
  end

end
