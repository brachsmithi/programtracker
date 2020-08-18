require 'rails_helper'

RSpec.describe "alternate_titles/index.html.haml", type: :view do

  context "with alternate titles" do
  
    before(:each) do
      assign(:alternate_titles, [
        create(:alternate_title, name: 'Zombi'),
        create(:alternate_title, name: 'The Adventures of Rat Pfink and Boo Boo')
      ])
    end

    it "displays alternate titles" do
      
      render

      expect(rendered).to match /Zombi/
      expect(rendered).to match /The Adventures of Rat Pfink and Boo Boo/
      expect(rendered).to match /show/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Alternate Titles/
      expect(rendered).to match /New Alternate Title/
    end

  end

  context 'on initial load' do
  
    before(:each) do
      assign(:alternate_titles, [])
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Alternate Titles/
      expect(rendered).to match /New Alternate Title/
    end

  end

end
