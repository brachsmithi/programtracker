require 'rails_helper'

RSpec.describe "programs/edit.html.haml", type: :view do

  before(:each) do
    director = create(:default_director)
    series = create(:series)
    assign(:program, create(:program))
    assign(:series, [series])
    assign(:directors, [director])
  end

  it 'displays the program form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Sort name/
    expect(rendered).to match /Year/
    expect(rendered).to match /Director/
    expect(rendered).to match /Series/
    expect(rendered).to match /Edit/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Edit Program/
  end
  
end
