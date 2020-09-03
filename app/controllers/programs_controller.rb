class ProgramsController < ApplicationController
  def index
    page = params[:page]
    if params[:search]
      @search_results_programs = Program.search_name(params[:search]).paginate(page: page, per_page: 15)
      respond_to do |format|
        format.html { @programs = @search_results_programs}
        format.js { render partial: 'search-results'}
      end
    else
      @programs = Program.all_by_sort_title.paginate(page: page, per_page: 15)
    end
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def show
    @program = Program.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
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
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
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
    page = params[:page]
    if @program.update program_params
      redirect_to program_path(@program, page: page)
    else
      @directors = Director.all_by_first_name
      @series = Series.all_sort_by_name
      @page = page
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

  def unused_report
    @programs = Program.unused.paginate(page: params[:page], per_page: 15)
  end

  def selector
    @set_id = params[:set_id]
    @link_id = params[:link_id]
    @programs = Program.all_by_sort_title
    respond_to do |format|
      format.html
      format.js
    end
  end

  def selector_search
    search_term = params[:term]
    @programs = Program.search_name search_term
    respond_to do |format|
      format.js
    end
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
