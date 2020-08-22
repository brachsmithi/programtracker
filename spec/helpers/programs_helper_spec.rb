require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProgramsHelper. For example:
#
# describe ProgramsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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

end
