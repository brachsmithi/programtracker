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
  end

  it "should display series data" do
    
    render

    expect(rendered).to match /Ray Milland Movies/
    expect(rendered).to match /3 - The Flying Scotsman \(1929\) - Full Screen/
    expect(rendered).to match /7 - Way for a Sailor \(1930\) - TV Edit/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Series List/
    expect(rendered).to match /Edit/
  end
  
end
