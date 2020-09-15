require 'rails_helper'

RSpec.describe "packages/index.html.haml", type: :view do
  
  context 'with packages' do
  
    before(:each) do
      assign(:packages, [
        create(:package, name: 'Godzilla Criterion Set'),
        create(:package, name: 'Universal Monster Set')
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all packages' do

      render

      expect(rendered).to have_content 'Godzilla Criterion Set'
      expect(rendered).to have_content 'Universal Monster Set'
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /destroy/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Package Index'
      expect(rendered).to have_link 'No Discs Report'
      expect(rendered).to have_link 'New Package'
    end

  end

  context 'on initial load' do
  
    before(:each) do
      assign(:packages, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Package Index'
      expect(rendered).to have_link 'No Discs Report'
      expect(rendered).to have_link 'New Package'
    end

  end
  
end
