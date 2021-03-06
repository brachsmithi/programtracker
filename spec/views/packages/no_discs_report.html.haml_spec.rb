require 'rails_helper'

RSpec.describe "packages/no_discs_report.html.haml", type: :view do
  
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
      expect(rendered).to_not match /edit/
      expect(rendered).to_not match /destroy/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_link 'Package List'
      expect(rendered).to have_content 'Packages With No Discs'
    end

  end

  context 'on initial load' do
  
    before(:each) do
      assign(:packages, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Package List/
      expect(rendered).to match /Packages With No Discs/
    end

  end
  
end
