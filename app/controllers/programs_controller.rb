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
  end

  def edit
    @program = Program.find params[:id]
    @directors = Director.all
  end

  def create
    @program = Program.new(program_params)
    if @program.save
      redirect_to @program
    else
      @directors = Director.all
      render 'new'
    end
  end

  def update
    @program = Program.find(params[:id])
    if @program.update(program_params)
      redirect_to @program
    else
      @directors = Director.all
      render 'edit'
    end
  end

  private

  def program_params
    params.require(:program).permit(:name, :sort_name, :year, director_ids:[])
  end

  def program_params_sans_associations
    params.require(:program).permit(:name, :sort_name, :year)
  end

end
