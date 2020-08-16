require 'rails_helper'

RSpec.describe "series/edit.html.haml", type: :view do
  
  before(:each) do
    assign(:series, Series.create(name: 'Dr. Mabuse'))
  end

  it 'displays the series form' do

    render

    expect(rendered).to match /Dr. Mabuse/
    expect(rendered).to match /Name/
    expect(rendered).to match /Edit/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Series/
  end

end
