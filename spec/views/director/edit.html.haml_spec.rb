require 'rails_helper'

RSpec.describe "directors/edit.html.haml", type: :view do

  before(:each) do
    assign(:director, create(:director))
  end

  it 'displays the director form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to have_link 'Add Alias'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'Edit Director'
    expect(rendered).to have_link 'Update'
    expect(rendered).to have_link 'Cancel'
  end
  
end
