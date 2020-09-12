require 'rails_helper'

RSpec.describe ProgramVersionCluster, type: :model do
  
  it 'should group versions of the same program' do
    p1 = create(:program, name: 'The Scorpion King', version: 'Widescreen')
    p2 = create(:program, name: 'The Scorpion King', version: 'Full Screen')
    pvc = create(:program_version_cluster)
    p1.program_version_cluster = pvc
    p1.save
    p2.program_version_cluster = pvc
    p2.save
    programs = pvc.programs
    expect(programs.count).to eq 2
    expect(programs[0].id).to eq p1.id
    expect(programs[1].id).to eq p2.id
  end

  describe 'associations' do
    it { should have_many(:programs).without_validating_presence.dependent(:nullify) }
    it { should accept_nested_attributes_for(:programs) }
  end
end
