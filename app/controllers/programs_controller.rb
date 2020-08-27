class ProgramsController < ApplicationController
  def index
    if params[:search]
      @search_results_programs = Program.search_name(params[:search]).paginate(page: params[:page], per_page: 15)
      respond_to do |format|
        format.html { @programs = @search_results_programs}
        format.js { render partial: 'search-results'}
      end
    else
      @programs = Program.all_by_sort_title.paginate(page: params[:page], per_page: 15)
    end
  end

  def show
    @program = Program.find params[:id]
  end

  def new
    @program = Program.new
    @directors = Director.all_by_first_name
    @series = Series.all_sort_by_name
  end

  def edit
    @program = Program.find params[:id]
    @directors = Director.all_by_first_name
    @series = Series.all_sort_by_name
  end

  def create
    @program = Program.new program_params
    if @program.save
      redirect_to @program
    else
      @directors = Director.all_by_first_name
      @series = Series.all_sort_by_name
      render 'new'
    end
  end

  def update
    @program = Program.find(params[:id])
    if @program.update program_params
      redirect_to @program
    else
      @directors = Director.all_by_first_name
      @series = Series.all_sort_by_name
      render 'edit'
    end
  end

  def destroy
    program = Program.find params[:id]
    program.destroy
    redirect_to action: 'index'
  end

  def duplicates_report
    @programs = Program.duplicates.paginate(page: params[:page], per_page: 15)
  end

  private

  def program_params
    programs_directors_attributes = params[:program][:programs_directors_attributes]
    unless programs_directors_attributes.nil?
      dids = programs_directors_attributes.to_unsafe_h.collect {|pda| pda[1][:director_id]}.uniq
      params[:program][:director_ids] = dids
    end

    series_programs_attributes = params[:program][:series_programs_attributes]
    unless series_programs_attributes.nil?
      sids = series_programs_attributes.to_unsafe_h.collect {|pda| pda[1][:series_id]}.uniq
      params[:program][:series_ids] = sids
    end

    params[:program][:programs_directors_attributes] = nil
    params[:program][:series_programs_attributes] = nil

    params.require(:program).permit(:name, :sort_name, :year, :version, :minutes, director_ids:[], series_ids:[], alternate_titles_attributes:[:program_id, :name])
  end

end
