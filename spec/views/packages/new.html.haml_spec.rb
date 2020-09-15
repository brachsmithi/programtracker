require 'rails_helper'

RSpec.describe "packages/new.html.haml", type: :view do
  
  before(:each) do
    assign(:package, Package.new)
  end

  it 'displays the package form' do

    render

    expect(rendered).to have_content 'Name'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Package'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end

end
