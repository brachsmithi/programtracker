require 'rails_helper'

RSpec.describe "packages/new.html.haml", type: :view do
  
  before(:each) do
    assign(:package, Package.new)
  end

  it 'displays the package form' do

    render

    expect(rendered).to match /Name/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Package/
    expect(rendered).to match /Create/
    expect(rendered).to match /Cancel/
  end

end
