require 'rails_helper'

RSpec.describe "series/new.html.haml", type: :view do
  
  before(:each) do
    assign(:series, Series.new)
  end

  it 'displays the series form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Create/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Series/
  end

end
