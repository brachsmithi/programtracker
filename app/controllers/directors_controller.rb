class DirectorsController < ApplicationController
  def index
    page = params[:page]
    if params[:search]
      @search_results_directors = Director.search_name(params[:search]).paginate(page: page, per_page: 15)
      respond_to do |format|
        format.html { @directors = @search_results_directors}
        format.js { render partial: 'search-results'}
      end
    else
      @directors = Director.all_by_last_name.paginate(page: page, per_page: 15)
    end
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def show
    @director = Director.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def new
    @director = Director.new
  end

  def edit
    @director = Director.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
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
    page = params[:page]
    if @director.update director_params
      redirect_to director_path(@director, page: page)
    else
      render 'edit'
      @page = page
    end
  end

  def destroy
    director = Director.find params[:id]
    director.destroy
    redirect_to action: 'index'
  end

  private

  def director_params
    params.require(:director).permit(:id, :name, director_aliases_attributes:[:id, :name])
  end
end
