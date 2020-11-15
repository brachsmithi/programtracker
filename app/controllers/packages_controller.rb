class PackagesController < ApplicationController

  def index
    if params[:search]
      @search = params[:search]
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
    @search = params[:search]
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
    @search = params[:search]
    @package = Package.find params[:id]
    if @package.update package_params
      redirect_to package_path(@package, page: @page, search: @search)
    else
      @page = page
      render 'edit'
    end
  end
  
  def show
    @package = Package.find params[:id]
    @search = params[:search]
  end

  def destroy
    package = Package.find params[:id]
    package.destroy
    redirect_to action: 'index'
  end

  def no_discs_report
    @packages = Package.no_discs.paginate(page: params[:page], per_page: 15)
  end

  def selector
    @set_id = params[:set_id]
    @link_id = params[:link_id]
    @packages = Package.all_by_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  def selector_search
    search_term = params[:term]
    @packages = Package.search_name search_term
    respond_to do |format|
      format.js
    end
  end

  private

  def package_params
    params.require(:package).permit(:id, :name, disc_packages_attributes:[:id, :sequence, :disc_id], series_packages_attributes:[:id, :sequence, :series_id])
  end

end
