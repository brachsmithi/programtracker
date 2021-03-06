require 'rails_helper'

RSpec.describe ProgramsHelper, type: :helper do

  context 'program_capsule' do

    it 'shows name, year, series, and version' do
      bond = create(:series, name: 'James Bond')
      program = create(:program, name: 'Moonraker', version: 'Full Screen', year: '1979')
      SeriesProgram.create(series_id: bond.id, program_id: program.id)

      expect(helper.program_capsule(program)).to eq('Moonraker (1979) - James Bond (Full Screen)')
    end

    it 'shows multiple series' do
      bond = create(:series, name: 'James Bond')
      moore = create(:series, name: 'Roger Moore Bond')
      program = create(:program, name: 'Moonraker', version: 'Full Screen', year: '1979')
      SeriesProgram.create(series_id: bond.id, program_id: program.id)
      SeriesProgram.create(series_id: moore.id, program_id: program.id)

      expect(helper.program_capsule(program)).to eq('Moonraker (1979) - James Bond, Roger Moore Bond (Full Screen)')
    end

    it 'shows only program, year, and series if there is no version' do
      bond = create(:series, name: 'James Bond')
      program = create(:program, name: 'Moonraker', version: '', year: '1979')
      SeriesProgram.create(series_id: bond.id, program_id: program.id)

      expect(helper.program_capsule(program)).to eq('Moonraker (1979) - James Bond')
    end

    it 'shows only name, year, and version if there are no series' do
      program = create(:program, name: 'Moonraker', version: 'Full Screen', year: '1979')

      expect(helper.program_capsule(program)).to eq('Moonraker (1979) (Full Screen)')
    end

    it 'shows only name if there is no other data' do
      program = create(:program, name: 'Moonraker', version: '', year: '')

      expect(helper.program_capsule(program)).to eq('Moonraker')
    end

  end
  
  context 'program_capsule_short' do

    it 'shows name, year, and version' do
      program = create(:program, name: 'Moonraker', version: 'Full Screen', year: '1979')

      expect(helper.program_capsule_short(program)).to eq('Moonraker (1979) - Full Screen')
    end

    it 'shows only program and year if there is no version' do
      program = create(:program, name: 'Moonraker', version: '', year: '1979')

      expect(helper.program_capsule_short(program)).to eq('Moonraker (1979)')
    end

    it 'shows only name if there is no other data' do
      program = create(:program, name: 'Moonraker', version: '', year: '')

      expect(helper.program_capsule_short(program)).to eq('Moonraker')
    end

  end

  describe 'program_capsule_year' do
    
    it 'shows program and year' do
      program = create(:program, name: 'Moonraker', version: '', year: '1979')

      expect(helper.program_capsule_year(program)).to eq('Moonraker (1979)')
    end

    it 'shows only name if there is no other data' do
      program = create(:program, name: 'Moonraker', version: '', year: '')

      expect(helper.program_capsule_year(program)).to eq('Moonraker')
    end

  end

  describe 'display_length' do

    it 'should convert minutes to hours' do
      expect(helper.display_length 120).to eq '2 hrs'
    end

    it 'should handle single hour' do
      expect(helper.display_length 60).to eq '1 hr'
    end

    it 'should include leftover minutes' do
      expect(helper.display_length 90).to eq '1 hr 30 min'
    end

    it 'should handle nil' do
      expect(helper.display_length nil).to eq ''
    end

  end

  describe 'duplicate_report_display' do
    
    it 'should list formats and locations' do
      program = create(:program, name: 'To Kill a Mocking Bird')
      disc1 = create(:disc, format: 'DVD', location: create(:location, name: 'T-1'))
      disc2 = create(:disc, format: 'Blu-ray', location: create(:location, name: 'T-3'))
      create(:disc_program, program_id: program.id, disc_id: disc1.id)
      create(:disc_program, program_id: program.id, disc_id: disc2.id)

      expect(helper.duplicate_report_display program).to eq '<a href="/programs/1">To Kill a Mocking Bird</a> - <a href="/discs/1">DVD (T-1)</a>, <a href="/discs/2">Blu-ray (T-3)</a>'
    end

    it 'should include package if available' do
      program = create(:program, name: 'The Thing With Two Heads')
      disc1 = create(:disc, format: 'DVD', location: create(:location, name: 'T-1'))
      disc2 = create(:disc, format: 'DVD', location: create(:location, name: 'Col-8'))
      create(:disc_program, program_id: program.id, disc_id: disc1.id)
      create(:disc_program, program_id: program.id, disc_id: disc2.id)
      package = create(:package, name: 'Two Heads are Better Than One Collection')
      create(:disc_package, disc_id: disc2.id, package_id: package.id)
      
      expect(helper.duplicate_report_display program).to eq '<a href="/programs/1">The Thing With Two Heads</a> - <a href="/discs/1">DVD (T-1)</a>, <a href="/packages/1">Two Heads are Better Than One Collection</a> <a href="/discs/2">DVD (Col-8)</a>'
   end

  end

end
