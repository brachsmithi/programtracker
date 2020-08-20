require 'rails_helper'

RSpec.describe "packages/edit.html.haml", type: :view do
  
  before(:each) do
    assign(:package, create(:package))
  end

  it 'displays the package form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Edit/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Package/
  end

end
