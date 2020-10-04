require 'rails_helper'

RSpec.describe "programs/duplicates_report.html.haml", type: :view do

  context 'with programs' do

    before(:each) do
      location = create(:location)

      notld = create(:program, name: 'Night of the Living Dead')
      notld_disc = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: notld_disc.id, program_id: notld.id)

      reefer = create(:program, name: 'Reefer Madness')
      reefer_disc = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: reefer_disc.id, program_id: reefer.id)

      reefer_blu = create(:disc, format: 'Blu-ray', location_id: location.id)
      create(:disc_program, disc_id: reefer_blu.id, program_id: reefer.id)

      fifty_disc = create(:disc, format: 'DVD-R', location_id: location.id)
      create(:disc_program, disc_id: fifty_disc.id, program_id: notld.id)
      create(:disc_program, disc_id: fifty_disc.id, program_id: reefer.id)
      
      assign(:programs, [
        notld,
        reefer
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'should display program data' do
      
      render

      expect(rendered).to have_link 'Night of the Living Dead'
      expect(rendered).to have_link 'DVD (NOT SET)'
      expect(rendered).to have_link 'DVD-R (NOT SET)'
      expect(rendered).to have_link 'Reefer Madness'
      expect(rendered).to have_link 'Blu-ray (NOT SET)'
    end

    it 'should display boilerplate' do
      
      render
      
      expect(rendered).to have_content 'Duplicated Programs'
      expect(rendered).to have_link 'Unused Report'
      expect(rendered).to have_link 'Program List'
    end

  end

end