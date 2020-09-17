require 'rails_helper'

RSpec.describe "series/new.html.haml", type: :view do
  
  before(:each) do
    assign(:series, Series.new)
    assign(:select_series, [create(:series, name: 'First Series'), create(:series, name: 'Second Series')])
  end

  it 'displays the series form' do

    render

    expect(rendered).to have_content 'Name'
    expect(rendered).to have_link 'Add Series'
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to have_content 'New Series'
    expect(rendered).to have_link 'Create'
    expect(rendered).to have_link 'Cancel'
  end

end
