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
  
  context 'sort_program' do

    it 'sorts programs by name' do 
      programs = [
        Program.new(name: 'Somewhere in Time', sort_name: ''),
        Program.new(name: 'The Chronicles of Riddick', sort_name: 'Chronicles of Riddick'),
        Program.new(name: 'Percy', sort_name: ''),
        Program.new(name: 'mom', sort_name: '')
      ]
      sorted = helper.sort_programs programs
      expect(sorted[0].name).to eq 'The Chronicles of Riddick'
      expect(sorted[1].name).to eq 'mom'
      expect(sorted[2].name).to eq 'Percy'
      expect(sorted[3].name).to eq 'Somewhere in Time'
    end

  end

  context 'program_capsule' do

    fit 'shows name, series, and version' do
      bond = create(:series, name: 'James Bond')
      program = create(:program, name: 'Moonraker', version: 'Full Screen')
      SeriesProgram.create(series_id: bond.id, program_id: program.id)

      expect(helper.program_capsule(program)).to eq('Moonraker - James Bond (Full Screen)')
    end

    xit 'shows multiple series' do
      bond = create(:series, name: 'James Bond')
      moore = create(:series, name: 'Roger Moore Bond')
      program = create(:program, name: 'Moonraker', version: 'Full Screen')
      SeriesProgram.create(series_id: bond.id, program_id: program.id)
      SeriesProgram.create(series_id: moore.id, program_id: program.id)

      expect(helper.program_capsule(program)).to eq('Moonraker - James Bond, Roger Moore Bond (Full Screen)')
    end

    xit 'shows only program and series if there is no version' do
      bond = create(:series, name: 'James Bond')
      program = create(:program, name: 'Moonraker', version: '')
      SeriesProgram.create(series_id: bond.id, program_id: program.id)

      expect(helper.program_capsule(program)).to eq('Moonraker - James Bond')
    end

    xit 'shows only name and version if there are no series' do
      program = create(:program, name: 'Moonraker', version: 'Full Screen')\

      expect(helper.program_capsule(program)).to eq('Moonraker (Full Screen)')
    end

  end

end
