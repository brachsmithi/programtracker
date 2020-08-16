require 'rails_helper'

RSpec.describe "discs/index.html.haml", type: :view do

  context 'with discs' do

    before(:each) do
      create(:default_director)
      loc = create(:default_location)
      disc = Disc.create!(location: loc, format: 'DVD-R', state: 'FILED')
      program1 = create(:program, name: 'My Neighbor Totoro')
      program2 = create(:program, name: 'Howl''s Moving Castle')
      DiscProgram.create(program: program1, disc: disc, program_type: 'FEATURE')
      DiscProgram.create(program: program2, disc: disc, program_type: 'BONUS')
      assign(:discs, [
        Disc.create!(location: loc, format: 'DVD', state: 'FILED'),
        disc
      ])
    end
    
    it 'displays all discs' do

      render

      expect(rendered).to match /My Neighbor Totoro/
      expect(rendered).to match /edit/
      expect(rendered).to match /show/
    end

    it 'only displays the first program on a disc' do
      
      render

      expect(rendered).to_not match /Howl's Moving Castle/
    end

    it 'displays default text for disc with no programs' do

      render

      expect(rendered).to match /--No Programs--/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Discs/
      expect(rendered).to match /New Disc/
    end

  end

  context 'with no discs' do

    before(:each) do
      assign(:discs, [])
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Discs/
      expect(rendered).to match /New Disc/
    end

  end

end
