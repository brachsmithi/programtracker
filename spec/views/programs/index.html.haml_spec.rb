require 'rails_helper'

RSpec.describe "programs/index.html.haml", type: :view do

  context 'with programs' do

    before(:each) do
      mib_ws = Program.create!(name: 'Men in Black II', version: 'Widescreen')
      mib_fs = Program.create!(name: 'Men in Black II', version: 'Full Screen')
      zl_1 = Program.create!(name: 'Zombieland')
      zl_2 = Program.create!(name: 'Zombieland: Double Tap')
      mib_series = create(:series, name: 'Men in Black')
      zl_series = create(:series, name: 'Zombieland Franchise')
      SeriesProgram.create(series_id: mib_series.id, program_id: mib_ws.id)
      SeriesProgram.create(series_id: mib_series.id, program_id: mib_fs.id)
      SeriesProgram.create(series_id: zl_series.id, program_id: zl_1.id)
      SeriesProgram.create(series_id: zl_series.id, program_id: zl_2.id)
      assign(:programs, [
        ProgramsSearch.find(mib_ws.id),
        ProgramsSearch.find(mib_fs.id),
        ProgramsSearch.find(zl_1.id),
        ProgramsSearch.find(zl_2.id)
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all programs' do

      render

      expect(rendered).to have_content 'Men in Black II - Men in Black (Widescreen)'
      expect(rendered).to have_content 'Men in Black II - Men in Black (Full Screen)'
      expect(rendered).to have_content 'Zombieland - Zombieland Franchise'
      expect(rendered).to have_content 'Zombieland: Double Tap - Zombieland Franchise'
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /destroy/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content /Program Index/
      expect(rendered).to have_link 'Duplicates Report'
      expect(rendered).to have_link 'New Program'
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:programs, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays without data' do
    
      render

      expect(rendered).to have_content 'Program Index'
      expect(rendered).to have_link 'Duplicates Report'
      expect(rendered).to have_link 'Unused Report'
      expect(rendered).to have_link 'New Program'
    end

  end
  
end
