class ProgramsController < ApplicationController
  def index
    @programs = Program.all
  end

  def show
    @program = Program.find params[:id]
  end

  def new
    @program = Program.new
    @directors = Director.all
    @series = Series.all
    @alternates = AlternateTitle.all
  end

  def edit
    @program = Program.find params[:id]
    @directors = Director.all
    @series = Series.all
  end

  def create
    @program = Program.new edit_params
    if @program.save
      redirect_to @program
    else
      @directors = Director.all
      @series = Series.all
      @alternates = AlternateTitle.all
      render 'new'
    end
  end

  def update
    @program = Program.find(params[:id])
    if @program.update(edit_params)
      redirect_to @program
    else
      @directors = Director.all
      @series = Series.all
      render 'edit'
    end
  end

  private

  def edit_params
    programs_directors_attributes = params[:program][:programs_directors_attributes]
    unless programs_directors_attributes.nil?
      dids = programs_directors_attributes.to_unsafe_h.collect {|pda| pda[1][:director_id]}.uniq
      params[:program][:director_ids] = dids
    end
    params[:program][:programs_directors_attributes]=nil
    params.require(:program).permit(:name, :sort_name, :year, director_ids:[], series_ids:[])
  end

  def program_params
    params.require(:program).permit(:name, :sort_name, :year, directors:[:id], director_ids:[], programs_directors_attributes:[:director_id], series_ids:[], series_programs:[series_ids:[]])
  end

end
