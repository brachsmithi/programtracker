require 'rails_helper'

RSpec.describe "directors/new.html.haml", type: :view do

  before(:each) do
    assign(:director, Director.new)
  end

  it 'displays the director form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to have_link 'Add Alias'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Director'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end
  
end
