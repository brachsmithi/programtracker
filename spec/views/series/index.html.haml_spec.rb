require 'rails_helper'

RSpec.describe "series/index.html.haml", type: :view do

  context 'with series' do
  
    before(:each) do
      assign(:series, [
        create(:series, name: 'Godzilla'),
        create(:series, name: 'James Bond')
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all series' do

      render

      expect(rendered).to have_content 'Godzilla'
      expect(rendered).to have_content 'James Bond'
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /destroy/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Series'
      expect(rendered).to have_link 'New Series'
    end

  end

  context 'on initial load' do
  
    before(:each) do
      assign(:series, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Series'
      expect(rendered).to have_link 'New Series'
    end

  end

end
