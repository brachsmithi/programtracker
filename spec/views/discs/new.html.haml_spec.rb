require 'rails_helper'

RSpec.describe "discs/new.html.haml", type: :view do

  context 'without an empty disc program' do

    before(:each) do
      assign(:disc, Disc.new)
      assign(:locations, [create(:default_location)])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to_not match /Program/
      expect(rendered).to_not match /Program Type/
      expect(rendered).to_not match /Sequence/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /New Disc/
    end

  end

  context 'with an empty disc program' do

    before(:each) do
      disc = Disc.new
      disc.disc_programs.build
      create(:default_director)
      assign(:disc, disc)
      assign(:locations, [create(:default_location)])
      assign(:programs, [create(:program)])
    end

    it 'displays the disc form' do

      render

      expect(rendered).to match /Format/
      expect(rendered).to match /State/
      expect(rendered).to match /Location/
      expect(rendered).to match /Program/
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
