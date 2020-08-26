require 'rails_helper'

RSpec.describe "locations/new.html.haml", type: :view do

  before(:each) do
    assign(:location, Location.new)
  end

  it 'displays the location form' do

    render

    expect(rendered).to match /Name/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Location/
    expect(rendered).to match /Create/
    expect(rendered).to match /Cancel/
  end

end
