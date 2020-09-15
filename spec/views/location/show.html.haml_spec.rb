require 'rails_helper'

RSpec.describe "locations/show.html.haml", type: :view do
  
  context 'with just location' do

    before(:each) do
      assign(:location, Location.create!(name: 'A-1'))
    end
    
    it 'displays the location' do

      render

      expect(rendered).to have_content 'A-1'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Location'
      expect(rendered).to have_link 'Location List'
      expect(rendered).to have_link 'Edit'
    end

  end

  context 'with discs' do

    before(:each) do
      location = Location.create!(name: 'B-1')
      Disc.create!({
        name: 'Buckaroo Banzai',
        format: 'DVD',
        state: 'FILED',
        location: location,
      })
      Disc.create!({
        name: 'Brick',
        format: 'DVD',
        state: 'FILED',
        location: location,
      })
      assign(:location, location)
    end
    
    it 'displays the location and discs' do

      render

      expect(rendered).to have_content 'B-1'
      expect(rendered).to have_link 'Buckaroo Banzai'
      expect(rendered).to have_link 'Brick'
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Location'
      expect(rendered).to have_link 'Location List'
      expect(rendered).to have_link 'Edit'
    end

  end

end
