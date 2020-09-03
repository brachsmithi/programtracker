class SeriesController < ApplicationController

  def index
    if params[:search]
      @search_results_series = Series.search_name(params[:search]).paginate(page: @page, per_page: 15)
      respond_to do |format|
        format.html { @series = @search_results_series}
        format.js { render partial: 'search-results'}
      end
    else
      @series = Series.all_sort_by_name.paginate(page: @page, per_page: 15)
    end
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
      redirect_to series_path(@series, page: @page) 
    else
      render "edit"
    end
  end

  def destroy
    series = Series.find params[:id]
    series.destroy
    redirect_to action: 'index'
  end

  private

  def series_params
    params.require(:series).permit(:name, series_programs_attributes:[:id, :sequence, :series_id, :program_id])
  end

end
