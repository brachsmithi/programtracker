class PersonsController < ApplicationController
  
  def index
    if params[:search]
      @search_results_persons = Person.search_name(params[:search]).paginate(page: @page, per_page: 15)
      @search = params[:search]
      respond_to do |format|
        format.html { @persons = @search_results_persons}
        format.js { render partial: 'search-results'}
      end
    else
      @persons = Person.all_by_last_name.paginate(page: @page, per_page: 15)
    end
  end

  def show
    @person = Person.find params[:id]
    @search = params[:search]
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find params[:id]
    @search = params[:search]
  end

  def create
    @person = Person.new person_params
    if @person.save
      redirect_to @person
    else
      render 'new'
    end
  end

  def update
    @person = Person.find params[:id]
    if @person.update person_params
      redirect_to person_path(@person, page: @page, search: params[:search])
    else
      render 'edit'
    end
  end

  def destroy
    person = Person.find params[:id]
    person.destroy
    redirect_to action: 'index'
  end

  def selector
    @set_id = params[:set_id]
    @link_id = params[:link_id]
    @persons = Person.all_by_first_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  def selector_search
    search_term = params[:term]
    @persons = Person.search_name search_term
    respond_to do |format|
      format.js
    end
  end

  private

  def person_params
    params.require(:person).permit(:id, :name, person_aliases_attributes:[:id, :name])
  end
end
