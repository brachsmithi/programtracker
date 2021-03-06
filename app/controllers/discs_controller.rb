class DiscsController < ApplicationController
  
  def index
    if params[:search]
      @search = params[:search]
      @search_results_discs = DiscsSearch.search_by_name(params[:search]).paginate(page: @page, per_page: 15)
      respond_to do |format|
        format.html { @discs = @search_results_discs}
        format.js { render partial: 'search-results'}
      end
    else
      @discs = DiscsSearch.all_by_name.paginate(page: @page, per_page: 15)
    end
  end

  def no_location_report
    @discs = Disc.not_located.paginate(page: params[:page], per_page: 15)
  end

  def show
    @disc = Disc.find params[:id]
    @allow_new = params[:allow_new]
    @search = params[:search]
  end

  def new
    @disc = Disc.new
    @disc.build_disc_package
    @disc.disc_programs.build
    @locations = Location.all_but_default
    @programs = ProgramsSearch.all_by_name
    @packages = Package.all_by_name
  end

  def create
    @disc = Disc.new(disc_params)
    if @disc.save
      redirect_to disc_path(@disc, allow_new: true)
    else
      @locations = Location.all_but_default
      @programs = ProgramsSearch.all_by_name
      @packages = Package.all_by_name
      render 'new'
    end
  end

  def edit
    @disc = Disc.find params[:id]
    @search = params[:search]
    @disc.build_disc_package if @disc.disc_package.nil?
    @locations = Location.all_but_default
    @programs = ProgramsSearch.all_by_name
    @packages = Package.all_by_name
  end

  def update
    @disc = Disc.find params[:id]
    @search = params[:search]
    if @disc.update disc_params 
      redirect_to disc_path(@disc, page: @page, search: @search)
    else
      @locations = Location.all_but_default
      @programs = ProgramsSearch.all_by_name
      @packages = Package.all_by_name
      render 'edit'
    end
  end

  def destroy
    disc = Disc.find params[:id]
    disc.destroy
    redirect_to action: 'index'
  end

  private

  def disc_params
    params.require(:disc).permit(:name, :format, :state, :location_id, 
      disc_package_attributes:[:id, :package_id, :sequence], 
      disc_programs_attributes:[:id, :program_id, :sequence, :program_type, :_destroy],
      series_discs_attributes:[:series_id]
    )
  end

end
