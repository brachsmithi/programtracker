require 'rails_helper'

RSpec.describe "directors/edit.html.haml", type: :view do

  before(:each) do
    assign(:director, create(:director))
  end

  it 'displays the director form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Add Alias/
    expect(rendered).to match /Update/
    expect(rendered).to match /Cancel/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Director/
  end
  
end
