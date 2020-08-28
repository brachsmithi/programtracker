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
        mib_ws,
        mib_fs,
        zl_1,
        zl_2
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all programs' do

      render

      expect(rendered).to match /Men in Black II - Men in Black \(Widescreen\)/
      expect(rendered).to match /Men in Black II - Men in Black \(Full Screen\)/
      expect(rendered).to match /Zombieland - Zombieland Franchise/
      expect(rendered).to match /Zombieland: Double Tap - Zombieland Franchise/
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
      expect(rendered).to match /delete/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to match /Programs/
      expect(rendered).to match /Duplicates Report/
      expect(rendered).to match /New Program/
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:programs, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays without data' do
    
      render

      expect(rendered).to match /Programs/
      expect(rendered).to match /Duplicates Report/
      expect(rendered).to match /Unused Report/
      expect(rendered).to match /New Program/
    end

  end
  
end
