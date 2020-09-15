require 'rails_helper'

RSpec.describe "locations/edit.html.haml", type: :view do

  before(:each) do
    assign(:location, Location.create(name: 'C-2'))
  end

  it 'displays the location form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to match /C-2/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'Edit Location'
    expect(rendered).to have_link 'Update'
    expect(rendered).to have_link 'Cancel'
  end

end
