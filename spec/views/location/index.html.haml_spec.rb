require 'rails_helper'

RSpec.describe "locations/index.html.haml", type: :view do
  
  context 'with locations' do

    before(:each) do
      location1 = Location.create(name: 'A-1')
      create(:disc, location_id: location1.id)
      create(:disc, location_id: location1.id)
      create(:disc, location_id: location1.id)
      location2 = Location.create(name: 'A-2')
      create(:disc, location_id: location2.id)
      create(:disc, location_id: location2.id)
      create(:disc, location_id: location2.id)
      create(:disc, location_id: location2.id)
      create(:disc, location_id: location2.id)
      assign(:locations, [
        location1,
        location2
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all locations' do

      render

      expect(rendered).to match /A-1 \(3\)/
      expect(rendered).to match /A-2 \(5\)/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Locations/
      expect(rendered).to match /New Location/
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:locations, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays without data' do
    
      render

      expect(rendered).to match /Locations/
      expect(rendered).to match /New Location/
    end

  end

end
