require 'rails_helper'

RSpec.describe "discs/no_location_report.html.haml", type: :view do

  context 'with discs' do

    before(:each) do
      loc = create(:default_location)

      disc1 = Disc.create(location: loc, format: 'Blu-ray', state: 'FILED')
      disc2 = Disc.create(location: loc, format: 'DVD', state: 'FILED')
      assign(:discs, [
        disc1,
        disc2
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all discs' do

      render

      expect(rendered).to match /--No Programs-- \(Blu-ray\)/
      expect(rendered).to match /--No Programs-- \(DVD\)/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /No Location Discs/
    end

  end

end
