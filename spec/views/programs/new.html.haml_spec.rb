require 'rails_helper'

RSpec.describe "programs/new.html.haml", type: :view do
  
  before(:each) do
    assign(:program, Program.new)
    assign(:series, [create(:series)])
    assign(:directors, [create(:director)])
    assign(:alternates, [create(:alternate_title)])
  end

  it 'displays the program form' do

    render

    expect(rendered).to match /Name/
    expect(rendered).to match /Sort name/
    expect(rendered).to match /Year/
    expect(rendered).to match /Director/
    expect(rendered).to match /Series/
    expect(rendered).to match /Alternate/
    expect(rendered).to match /Create/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /New Program/
  end

end
