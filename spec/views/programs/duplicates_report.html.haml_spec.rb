require 'rails_helper'

RSpec.describe "programs/duplicates_report.html.haml", type: :view do

  context 'with programs' do

    before(:each) do
      location = create(:default_location)

      notld = create(:program, name: 'Night of the Living Dead')
      notld_disc = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: notld_disc.id, program_id: notld.id)

      reefer = create(:program, name: 'Reefer Madness')
      reefer_disc = create(:disc, format: 'DVD', location_id: location.id)
      create(:disc_program, disc_id: reefer_disc.id, program_id: reefer.id)

      reefer_blu = create(:disc, format: 'Blu-ray', location_id: location.id)
      create(:disc_program, disc_id: reefer_blu.id, program_id: reefer.id)

      fifty_disc = create(:disc, format: 'DVD', location_id: location.id)
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

      expect(rendered).to match /Night of the Living Dead - DVD \(NOT SET\), DVD \(NOT SET\)/
      expect(rendered).to match /Reefer Madness - DVD \(NOT SET\), Blu-ray \(NOT SET\), DVD \(NOT SET\)/
    end

    it 'should display boilerplate' do
      
      render
      
      expect(rendered).to match /Duplicated Programs/
      expect(rendered).to match /Program List/
    end

  end

end