class AlternateTitlesController < ApplicationController
  def index
    page = params[:page]
    @alternate_titles = AlternateTitle.all_by_name.paginate(page: page, per_page: 15)
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def new
    @alternate_title = AlternateTitle.new
    @programs = Program.all
  end

  def edit
    @alternate_title = AlternateTitle.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
  end

  def show
    @alternate_title = AlternateTitle.find params[:id]
    page = params[:page]
    unless page.nil? || page == '1'
      @page = page
    end
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

  def update
    page = params[:page]
    @alternate_title = AlternateTitle.find params[:id]
    if @alternate_title.update alternate_title_params
      redirect_to alternate_title_path(@alternate_title, page: page)
    else
      @page = page
      render 'edit'
    end
  end

  def destroy
    alternate_title = AlternateTitle.find params[:id]
    alternate_title.destroy
    redirect_to action: 'index'
  end

  private

  def alternate_title_params
    params.require(:alternate_title).permit(:id, :name, :program_id)
  end
end
