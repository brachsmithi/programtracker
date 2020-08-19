class DirectorsController < ApplicationController
  def index
    @directors = Director.all
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
    params.require(:director).permit(:id, :name, director_aliases_attributes:[:name])
  end
end
