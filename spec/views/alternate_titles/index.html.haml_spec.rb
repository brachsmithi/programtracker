require 'rails_helper'

RSpec.describe "alternate_titles/index.html.haml", type: :view do

  context "with alternate titles" do
  
    before(:each) do
      p1 = create(:program, name: 'Zombie')
      p2 = create(:program, name: 'Rat Pfink a Boo Boo')
      assign(:alternate_titles, [
        create(:alternate_title, name: 'Zombi 2', program_id: p1.id),
        create(:alternate_title, name: 'The Adventures of Rat Pfink and Boo Boo', program_id: p2.id)
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it "displays alternate titles" do
      
      render

      expect(rendered).to match /Zombi 2 - Zombie/
      expect(rendered).to match /The Adventures of Rat Pfink and Boo Boo - Rat Pfink a Boo Boo/
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /delete/
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
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Alternate Titles/
      expect(rendered).to match /New Alternate Title/
    end

  end

end
