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
