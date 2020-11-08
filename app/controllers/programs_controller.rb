class ProgramsController < ApplicationController

  def index
    if params[:search]
      @search = params[:search]
      @search_results_programs = ProgramsSearch.search_by_name(params[:search]).paginate(page: @page, per_page: 15)
      respond_to do |format|
        format.html { @programs = @search_results_programs}
        format.js { render partial: 'search-results'}
      end
    else
      @programs = ProgramsSearch.all_by_name.paginate(page: @page, per_page: 15)
    end
  end

  def show
    @program = Program.find params[:id]
    @search = params[:search]
  end

  def new
    @program = Program.new
    @series = Series.all_sort_by_name
  end

  def edit
    @program = Program.find params[:id]
    @series = Series.all_sort_by_name
    @search = params[:search]
  end

  def create
    @program = Program.new program_params
    if @program.save
      redirect_to @program
    else
      @series = Series.all_sort_by_name
      render 'new'
    end
  end

  def update
    @program = Program.find(params[:id])
    @search = params[:search]
    if @program.update program_params
      redirect_to program_path(@program, page: @page, search: @search)
    else
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

  def unused_report
    @programs = Program.unused.paginate(page: params[:page], per_page: 15)
  end

  def selector
    @set_id = params[:set_id]
    @link_id = params[:link_id]
    @programs = ProgramsSearch.all_by_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  def selector_search
    search_term = params[:term]
    @programs = ProgramsSearch.search_by_name search_term
    respond_to do |format|
      format.js
    end
  end

  def new_version
    op = Program.find params[:id]
    np = op.dup
    np.save!
    op.persons.each {|d| np.persons << d}
    op.series.each {|s| np.series << s}
    op.alternate_titles.each {|at| np.alternate_titles << AlternateTitle.new(name: at.name)}
    if op.program_version_cluster.nil?
      pvc = ProgramVersionCluster.create!
      pvc.programs << op
      pvc.programs << np
    end
    redirect_to action: 'edit', id: np.id
  end

  private

  def program_params
    program_persons_attributes = params[:program][:program_persons_attributes]
    unless program_persons_attributes.nil?
      dids = program_persons_attributes.to_unsafe_h.select {
        |pda| 
        destroy_val = program_persons_attributes[pda][:_destroy]
        destroy_val != '1'
      }.collect {
        |pda| 
        pda[1][:person_id]
      }.uniq
      params[:program][:person_ids] = dids
    end

    series_programs_attributes = params[:program][:series_programs_attributes]
    unless series_programs_attributes.nil?
      sids = series_programs_attributes.to_unsafe_h.collect {|pda| pda[1][:series_id]}.uniq
      params[:program][:series_ids] = sids
    end

    params[:program][:program_persons_attributes] = nil
    params[:program][:series_programs_attributes] = nil

    params.require(:program).permit(:name, :sort_name, :year, :version, :minutes, person_ids:[], series_ids:[], alternate_titles_attributes:[:program_id, :name])
  end

end
