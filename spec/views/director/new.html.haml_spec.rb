require 'rails_helper'

RSpec.describe "directors/new.html.haml", type: :view do

  before(:each) do
    assign(:director, Director.new)
  end

  it 'displays the director form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Add Alias/
    expect(rendered).to match /Create/
    expect(rendered).to match /Cancel/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Director/
  end
  
end
