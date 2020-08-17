require 'rails_helper'

RSpec.describe "series/show.html.haml", type: :view do
  
  before(:each) do
    assign(:series, create(:series, name: 'Ray Milland Movies'))
  end

  it "should display series data" do
    
    render

    expect(rendered).to match /Ray Milland Movies/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Series/
  end
  
end
