require 'rails_helper'

RSpec.describe "programs/new.html.haml", type: :view do
  
  before(:each) do
    assign(:program, Program.new)
    assign(:series, [create(:series)])
    assign(:persons, [create(:person)])
    assign(:alternates, [create(:alternate_title)])
  end

  it 'displays the program form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to have_content 'Sort name'
    expect(rendered).to have_content 'Year'
    expect(rendered).to have_content 'Version'
    expect(rendered).to have_content 'Length'
    expect(rendered).to have_content 'Person'
    expect(rendered).to have_content 'Series'
    expect(rendered).to have_content 'Alternate'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Program'
  end

end
