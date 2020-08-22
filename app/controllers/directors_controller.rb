class DirectorsController < ApplicationController
  def index
    if params[:search]
      @search_results_directors = Director.search_name(params[:search]).paginate(page: params[:page], per_page: 15)
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @directors = Director.all_by_last_name.paginate(page: params[:page], per_page: 15)
    end
  end

  def show
    @director = Director.find params[:id]
  end

  def new
    @director = Director.new
  end

  def edit
    @director = Director.find params[:id]
  end

  def search
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
      redirect_to @director
    else
      render 'edit'
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
