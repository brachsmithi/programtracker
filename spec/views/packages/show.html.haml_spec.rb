require 'rails_helper'

RSpec.describe "packages/show.html.haml", type: :view do
  
  before(:each) do
    assign(:package, create(:package, name: 'Honey West: The Complete Series'))
  end

  it "should display package data" do
    
    render

    expect(rendered).to match /Honey West: The Complete Series/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Package/
    expect(rendered).to match /Packages/
  end
end
