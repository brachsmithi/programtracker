class PackagesController < ApplicationController

  def index
    @packages = Package.all
  end

  def new
    @package = Package.new
  end

  def edit
    @package = Package.find params[:id]
  end

  def create
    @package = Package.new package_params
    if @package.save
      redirect_to @package
    else
      render 'new'
    end
  end

  def update
    @package = Package.find params[:id]
    if @package.update package_params
      redirect_to @package
    else
      render 'edit'
    end
  end
  
  def show
    @package = Package.find params[:id]
  end

  private

  def package_params
    params.require(:package).permit(:id, :name)
  end

end
