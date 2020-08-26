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

    it 'shows only program, yaear, and series if there is no version' do
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

end
