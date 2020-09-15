require 'rails_helper'

RSpec.describe "discs/index.html.haml", type: :view do

  context 'with discs' do

    before(:each) do
      loc = create(:default_location)
      disc = Disc.create!(location: loc, format: 'DVD-R', state: 'FILED')
      program1 = create(:program, name: 'My Neighbor Totoro')
      program2 = create(:program, name: 'Howl''s Moving Castle')
      DiscProgram.create(program: program1, disc: disc, program_type: 'FEATURE')
      DiscProgram.create(program: program2, disc: disc, program_type: 'BONUS')
      assign(:discs, [
        Disc.create!(location: loc, format: 'Blu-ray', state: 'FILED'),
        disc
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all discs' do

      render

      expect(rendered).to have_content '--No Programs--'
      expect(rendered).to have_content 'DVD-R'
      expect(rendered).to have_content '(NOT SET)'
      expect(rendered).to have_content 'My Neighbor Totoro'
      expect(rendered).to have_content 'Blu-ray'
      expect(rendered).to match /edit/
      expect(rendered).to match /show/
      expect(rendered).to match /destroy/
    end

    it 'only displays the first program on a disc' do
      
      render

      expect(rendered).to_not match /Howl's Moving Castle/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Disc Index'
      expect(rendered).to have_link 'New Disc'
      expect(rendered).to have_link 'No Location Report'
    end

  end

  context 'with no discs' do

    before(:each) do
      assign(:discs, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Disc Index'
      expect(rendered).to have_link 'New Disc'
      expect(rendered).to have_link 'No Location Report'
    end

  end

end
