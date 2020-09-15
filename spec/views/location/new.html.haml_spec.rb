require 'rails_helper'

RSpec.describe "locations/new.html.haml", type: :view do

  before(:each) do
    assign(:location, Location.new)
  end

  it 'displays the location form' do

    render

    expect(rendered).to have_content 'Name'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Location'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end

end
