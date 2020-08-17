require 'rails_helper'

RSpec.describe "alternate_titles/show.html.haml", type: :view do
  
  before(:each) do
    create(:default_director)
    assign(:alternate_title, create(:alternate_title, name: 'Zombie'))
  end

  it "should display alternate title data" do
    
    render

    expect(rendered).to match /Zombie/
  end

  it 'displays all boilerplate' do

    render

    expect(rendered).to match /Alternate Titles/
  end

end
