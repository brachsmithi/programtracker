require 'rails_helper'

RSpec.describe "series/show.html.haml", type: :view do
  
  before(:each) do
    location = create(:default_location)
    series = create(:series, name: 'Ray Milland Movies')
    program1 = create(:program, name: 'The Flying Scotsman')
    program2 = create(:program, name: 'The Lady from the Sea')
    assign(:series, series)
    create(:series_program, series_id: series.id, program_id: program1.id, sequence: 3)
    create(:series_program, series_id: series.id, program_id: program2.id, sequence: 4)
  end

  it "should display series data" do
    
    render

    expect(rendered).to match /Ray Milland Movies/
    expect(rendered).to match /The Flying Scotsman/
    expect(rendered).to match /The Lady from the Sea/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Series/
  end
  
end
