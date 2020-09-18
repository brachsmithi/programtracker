class SeriesController < ApplicationController

  def index
    if params[:search]
      @search = params[:search]
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
    @search = params[:search]
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
    @search = params[:search]
  end

  def update
    @series = Series.find params[:id]
    @search = params[:search]
    if @series.update series_params
      redirect_to series_path(@series, page: @page, search: @search) 
    else
      render "edit"
    end
  end

  def destroy
    series = Series.find params[:id]
    series.destroy
    redirect_to action: 'index'
  end

  def selector
    @set_id = params[:set_id]
    @link_id = params[:link_id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def selector_search
    search_term = params[:term]
    @series = Series.search_name search_term
    respond_to do |format|
      format.js
    end
  end

  private

  def series_params
    # series_series_attributes = params[:series][:series_series_attributes]
    # unless series_series_attributes.nil?
    #   series_series_attributes.each do |ssa|
    #     if ssa[:contained_series_id]
    # end
p params
    params.require(:series).permit(:name, series_programs_attributes:[:id, :sequence, :series_id, :program_id], series_series_attributes:[:id, :sequence, :wrapper_series_id, :contained_series_id])
  end

end
