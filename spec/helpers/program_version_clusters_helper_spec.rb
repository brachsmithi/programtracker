require 'rails_helper'

RSpec.describe ProgramVersionClustersHelper, type: :helper do
  
  describe 'program_version_cluster_capsule' do

    it 'should list version information' do
      p1 = create(:program, name: 'Deathtrap', version: 'Widescreen')
      p2 = create(:program, name: 'Deathtrap', version: 'Full Screen')
      pvc = create(:program_version_cluster)
      pvc.programs << p1
      pvc.programs << p2

      expect(helper.program_version_cluster_capsule pvc).to eq 'Deathtrap - Widescreen, Full Screen'
    end

    it 'should handle a cluster without programs' do
      pvc = create(:program_version_cluster)

      expect(helper.program_version_cluster_capsule pvc).to eq '--NO PROGRAMS--'
    end

  end

end
