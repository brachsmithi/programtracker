require 'rails_helper'

RSpec.describe "discs/edit.html.haml", type: :view do
  
  context 'without programs' do

    before(:each) do
      disc = create(:disc)
      assign(:disc, disc)
      assign(:locations, [disc.location])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Edit/
      expect(rendered).to_not match /Program/
      expect(rendered).to_not match /Program Type/
      expect(rendered).to_not match /Sequence/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Disc/
    end

  end

  context 'with programs' do

    before(:each) do
      disc = create(:disc)
      create(:default_director)
      program1 = create(:program, name: 'The Planet of the Apes')
      program2 = create(:program, name: 'Roddy McDowall Interview')
      DiscProgram.create(disc: disc, program_type: 'FEATURE', program: program1)
      DiscProgram.create(disc: disc, program_type: 'BONUS', program: program2)
      assign(:disc, disc)
      assign(:locations, [disc.location])
      assign(:programs, [program1, program2, create(:program, name: 'Beneath the Planet of the Apes')])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Edit/
      expect(rendered).to match /Program/
      expect(rendered).to match /Program type/
      expect(rendered).to match /Sequence/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Disc/
    end

  end

end
