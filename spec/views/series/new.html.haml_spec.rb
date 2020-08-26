require 'rails_helper'

RSpec.describe "series/new.html.haml", type: :view do
  
  before(:each) do
    assign(:series, Series.new)
  end

  it 'displays the series form' do

    render

    expect(rendered).to match /Name/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Series/
    expect(rendered).to match /Create/
    expect(rendered).to match /Cancel/
  end

end
