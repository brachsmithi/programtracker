require 'rails_helper'

RSpec.describe "alternate_titles/show.html.haml", type: :view do
  
  before(:each) do
    program = create(:program, name: 'Dawn of the Dead')
    assign(:alternate_title, create(:alternate_title, name: 'Zombie', program_id: program.id))
  end

  it "should display alternate title data" do
    
    render

    expect(rendered).to match /Zombie/
    expect(rendered).to match /Dawn of the Dead/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Alternate Title List/
  end

end
