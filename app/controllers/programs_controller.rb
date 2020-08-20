class ProgramsController < ApplicationController
  def index
    @programs = Program.all_by_sort_title.paginate(page: params[:page], per_page: 25)
  end

  def show
    @program = Program.find params[:id]
  end

  def new
    @program = Program.new
    @directors = Director.all_by_first_name
    @series = Series.all
    @alternates = AlternateTitle.all
  end

  def edit
    @program = Program.find params[:id]
    @directors = Director.all_by_first_name
    @series = Series.all
  end

  def create
    @program = Program.new program_params
    if @program.save
      redirect_to @program
    else
      @directors = Director.all_by_first_name
      @series = Series.all
      @alternates = AlternateTitle.all
      render 'new'
    end
  end

  def update
    @program = Program.find(params[:id])
    if @program.update program_params
      redirect_to @program
    else
      @directors = Director.all_by_first_name
      @series = Series.all
      render 'edit'
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

    params.require(:program).permit(:name, :sort_name, :year, :version, :minutes, director_ids:[], series_ids:[])
  end

end
