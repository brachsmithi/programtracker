require 'rails_helper'

RSpec.describe "locations/edit.html.haml", type: :view do

  before(:each) do
    assign(:location, Location.create(name: 'C-2'))
  end

  it 'displays the location form' do

    render

    expect(rendered).to match /C-2/
    expect(rendered).to match /Name/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Location/
    expect(rendered).to match /Update/
    expect(rendered).to match /Cancel/
  end

end
