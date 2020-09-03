class PackagesController < ApplicationController

  def index
    if params[:search]
      @search_results_packages = Package.search_name(params[:search]).paginate(page: @page, per_page: 15)
      respond_to do |format|
        format.html { @packages = @search_results_packages}
        format.js { render partial: 'search-results'}
      end
    else
      @packages = Package.all_by_name.paginate(page: @page, per_page: 15)
    end
  end

  def new
    @package = Package.new
  end

  def edit
    @package = Package.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
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
    page = params[:page]
    @package = Package.find params[:id]
    if @package.update package_params
      redirect_to package_path(@package, page: page)
    else
      @page = page
      render 'edit'
    end
  end
  
  def show
    @package = Package.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def destroy
    package = Package.find params[:id]
    package.destroy
    redirect_to action: 'index'
  end

  def no_discs_report
    @packages = Package.no_discs.paginate(page: params[:page], per_page: 15)
  end

  private

  def package_params
    params.require(:package).permit(:id, :name, disc_packages_attributes:[:id, :sequence, :disc_id])
  end

end
