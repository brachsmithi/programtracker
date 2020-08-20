class AlternateTitlesController < ApplicationController
  def index
    @alternate_titles = AlternateTitle.all
  end

  def new
    @alternate_title = AlternateTitle.new
    @programs = Program.all
  end

  def create
    @alternate_title = AlternateTitle.new(alternate_title_params)
    if @alternate_title.save
      redirect_to @alternate_title
    else
      @programs = Program.all
      render "new"
    end
  end

  def show
    @alternate_title = AlternateTitle.find params[:id]
  end

  private

  def alternate_title_params
    params.require(:alternate_title).permit(:name, :program_id)
  end
end