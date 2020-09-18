require 'rails_helper'

RSpec.describe "series/show.html.haml", type: :view do
  
  before(:each) do
    location = create(:default_location)
    series = create(:series, name: 'Ray Milland Movies')
    program1 = create(:program, name: 'The Flying Scotsman', version: 'Full Screen', year: '1929')
    program2 = create(:program, name: 'Way for a Sailor', version: 'TV Edit', year: '1930')
    assign(:series, series)
    create(:series_program, series_id: series.id, program_id: program1.id, sequence: 3)
    create(:series_program, series_id: series.id, program_id: program2.id, sequence: 7)
    create(:series_series, wrapper_series_id: create(:series, name: 'Wrapper').id, contained_series_id: series.id)
    create(:series_series, sequence: 2, wrapper_series_id: series.id, contained_series_id: create(:series, name: 'Contained').id)
  end

  it "should display series data" do
    
    render

    expect(rendered).to match /Ray Milland Movies/
    expect(rendered).to have_link '3 - The Flying Scotsman (1929) - Full Screen'
    expect(rendered).to have_link '7 - Way for a Sailor (1930) - TV Edit'
    expect(rendered).to have_link 'Wrapper'
    expect(rendered).to have_link '2 - Contained'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_link 'Series List'
    expect(rendered).to have_link 'Edit'
  end
  
end
