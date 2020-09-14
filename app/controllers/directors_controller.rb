class DirectorsController < ApplicationController
  
  def index
    if params[:search]
      @search_results_directors = Director.search_name(params[:search]).paginate(page: @page, per_page: 15)
      @search = params[:search]
      respond_to do |format|
        format.html { @directors = @search_results_directors}
        format.js { render partial: 'search-results'}
      end
    else
      @directors = Director.all_by_last_name.paginate(page: @page, per_page: 15)
    end
  end

  def show
    @director = Director.find params[:id]
    @search = params[:search]
  end

  def new
    @director = Director.new
  end

  def edit
    @director = Director.find params[:id]
    @search = params[:search]
  end

  def create
    @director = Director.new director_params
    if @director.save
      redirect_to @director
    else
      render 'new'
    end
  end

  def update
    @director = Director.find params[:id]
    if @director.update director_params
      redirect_to director_path(@director, page: @page, search: params[:search])
    else
      render 'edit'
    end
  end

  def destroy
    director = Director.find params[:id]
    director.destroy
    redirect_to action: 'index'
  end

  def selector
    @set_id = params[:set_id]
    @link_id = params[:link_id]
    @directors = Director.all_by_first_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  def selector_search
    search_term = params[:term]
    @directors = Director.search_name search_term
    p @directors
    respond_to do |format|
      format.js
    end
  end

  private

  def director_params
    params.require(:director).permit(:id, :name, director_aliases_attributes:[:id, :name])
  end
end
