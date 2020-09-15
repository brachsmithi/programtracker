require 'rails_helper'

RSpec.describe "programs/unused_report.html.haml", type: :view do

  context 'with programs' do

    before(:each) do
      program1 = create(:program, name: 'The Davinci Code')
      program2 = create(:program, name: 'Air Bud')
      
      assign(:programs, [
        program1,
        program2
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'should display program data' do
      
      render

      expect(rendered).to have_content 'The Davinci Code'
      expect(rendered).to have_content 'Air Bud'
    end

    it 'should display boilerplate' do
      
      render
      
      expect(rendered).to have_content 'Unused Programs'
      expect(rendered).to have_link 'Duplicates Report'
      expect(rendered).to have_link 'Program List'
    end

  end

end