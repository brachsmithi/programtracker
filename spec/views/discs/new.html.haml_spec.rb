require 'rails_helper'

RSpec.describe "discs/new.html.haml", type: :view do

  context 'without an empty disc program' do

    before(:each) do
      assign(:disc, Disc.new)
      assign(:packages, [create(:package, name: 'Star Trek: Season One')])
      assign(:locations, [create(:default_location)])
      assign(:programs, [create(:program)])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Add Program/
      expect(rendered).to match /Sequence/
      expect(rendered).to_not match /Package/
      expect(rendered).to_not match /Star Trek: Season One/
      expect(rendered).to_not match /Program Type/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /New Disc/
    end

  end

  context 'with an empty disc program and package' do

    before(:each) do
      disc = Disc.new
      disc.disc_programs.build
      disc.build_disc_package
      assign(:disc, disc)
      assign(:locations, [create(:default_location)])
      assign(:programs, [create(:program)])
      assign(:packages, [create(:package, name: 'Star Trek: Season One')]) 
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Package/
      expect(rendered).to match /Star Trek: Season One/
      expect(rendered).to match /Add Program/
      expect(rendered).to match /Program type/
      expect(rendered).to match /Sequence/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /New Disc/
      expect(rendered).to match /Create/
    end

  end

end
