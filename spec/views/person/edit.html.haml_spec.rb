require 'rails_helper'

RSpec.describe "persons/edit.html.haml", type: :view do

  before(:each) do
    assign(:person, create(:person))
  end

  it 'displays the person form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to have_link 'Add Alias'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'Edit Person'
    expect(rendered).to have_link 'Update'
    expect(rendered).to have_link 'Cancel'
  end
  
end
