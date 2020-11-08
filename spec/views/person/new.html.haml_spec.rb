require 'rails_helper'

RSpec.describe "persons/new.html.haml", type: :view do

  before(:each) do
    assign(:person, Person.new)
  end

  it 'displays the person form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to have_link 'Add Alias'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Person'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end
  
end
