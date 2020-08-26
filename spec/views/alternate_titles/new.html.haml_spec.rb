require 'rails_helper'

RSpec.describe "alternate_titles/new.html.haml", type: :view do

  before(:each) do
    assign(:alternate_title, AlternateTitle.new)
    assign(:programs, [create(:program, name: 'Cash On Demand')])
  end

  it 'displays the alternate title form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Program/
    expect(rendered).to match /Cash On Demand/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Alternate Title/
    expect(rendered).to match /Create/
    expect(rendered).to match /Cancel/
  end

end
