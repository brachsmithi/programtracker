class PackagesController < ApplicationController

  def index
    @packages = Package.all
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      redirect_to @package
    else
      render 'new'
    end
  end
  
  def show
    @package = Package.find params[:id]
  end

  private

  def package_params
    params.require(:package).permit(:name)
  end

end
