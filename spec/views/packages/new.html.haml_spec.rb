require 'rails_helper'

RSpec.describe "packages/new.html.haml", type: :view do
  
  before(:each) do
    assign(:package, Package.new)
  end

  it 'displays the package form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Create/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Package/
  end

end
