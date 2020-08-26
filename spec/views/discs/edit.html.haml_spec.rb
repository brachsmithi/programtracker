require 'rails_helper'

RSpec.describe "discs/edit.html.haml", type: :view do
  
  context 'without programs or package' do

    before(:each) do
      disc = create(:disc)
      assign(:disc, disc)
      assign(:locations, [disc.location])
      assign(:packages, [create(:package, name: 'The Americans: The Complete Series')])
      assign(:programs, [create(:program)])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Edit/
      expect(rendered).to match /Add Program/
      expect(rendered).to match /Sequence/
      expect(rendered).to_not match /Package/
      expect(rendered).to_not match /The Americans: The Complete Series/
      expect(rendered).to_not match /Program Type/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Disc/
      expect(rendered).to match /Update/
      expect(rendered).to match /Cancel/
    end

  end

  context 'with programs and empty package' do

    before(:each) do
      disc = create(:disc)
      disc.build_disc_package
      program1 = create(:program, name: 'The Planet of the Apes')
      program2 = create(:program, name: 'Roddy McDowall Interview')
      DiscProgram.create(disc: disc, program_type: 'FEATURE', program: program1)
      DiscProgram.create(disc: disc, program_type: 'BONUS', program: program2)
      assign(:disc, disc)
      assign(:locations, [disc.location])
      assign(:programs, [program1, program2, create(:program, name: 'Beneath the Planet of the Apes')])
      assign(:packages, [create(:package, name: 'The Americans: The Complete Series')])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Edit/
      expect(rendered).to match /Package/
      expect(rendered).to match /The Americans: The Complete Series/
      expect(rendered).to match /Program/
      expect(rendered).to match /Program type/
      expect(rendered).to match /Sequence/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Edit Disc/
      expect(rendered).to match /Update/
      expect(rendered).to match /Cancel/
    end

  end

end
