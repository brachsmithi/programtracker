class DiscsController < ApplicationController
  def index
    @discs = Disc.all
  end

  def show
    @disc = Disc.find params[:id]
  end

  def new
    @disc = Disc.new
    @locations = Location.all_but_default
  end

  def create
    @disc = Disc.new(disc_params)
    if @disc.save
      redirect_to @disc
    else
      @locations = Location.all_but_default
      render 'new'
    end
  end

  def edit
    @disc = Disc.find params[:id]
    @locations = Location.all_but_default
  end

  def update
    @disc = Disc.find(params[:id])
    if @disc.update(disc_params)
      redirect_to @disc
    else
      @locations = Location.all_but_default
      render 'edit'
    end
  end

  private

  def disc_params
    params.require(:disc).permit(:format, :state, :location_id)
  end

end
