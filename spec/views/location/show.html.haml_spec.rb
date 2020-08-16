require 'rails_helper'

RSpec.describe "locations/show.html.haml", type: :view do
  
  context 'with location' do

    before(:each) do
      assign(:location, Location.create!(name: 'A-1'))
    end
    
    it 'displays the location' do

      render

      expect(rendered).to match /A-1/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Location/
      expect(rendered).to match /Locations/
    end

  end

end
