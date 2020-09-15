require 'rails_helper'

RSpec.describe "program_version_clusters/index.html.haml", type: :view do

  context 'with clusters' do

    before(:each) do
      mib_ws = create(:program, name: 'Men in Black II', version: 'Widescreen')
      mib_fs = create(:program, name: 'Men in Black II', version: 'Full Screen')
      pvc1 = create(:program_version_cluster)
      pvc1.programs << mib_fs
      pvc1.programs << mib_ws
      br_tc = create(:program, name: "Blade Runner", version: 'Theatrical Release')
      br_dc = create(:program, name: "Blade Runner", version: 'Director Cut')
      pvc2 = create(:program_version_cluster)
      pvc2.programs << br_tc
      pvc2.programs << br_dc
      
      assign(:program_version_clusters, [
        pvc1,
        pvc2
      ])
      allow(view).to receive_messages(:will_paginate => nil)
    end
    
    it 'displays all clusters' do

      render

      expect(rendered).to have_content 'Men in Black II - Widescreen, Full Screen'
      expect(rendered).to have_content 'Blade Runner - Theatrical Release, Director Cut'
      expect(rendered).to match /show/
      expect(rendered).to match /edit/
    end

    it 'displays all boilerplate' do

      render

      expect(rendered).to have_content 'Program Version Cluster'
      expect(rendered).to have_link 'New Cluster'
    end

  end

  context 'on initial load' do
    before(:each) do
      assign(:program_version_clusters, [])
      allow(view).to receive_messages(:will_paginate => nil)
    end

    it 'displays without data' do
    
      render

      expect(rendered).to have_content 'Program Version Cluster'
      expect(rendered).to have_link 'New Cluster'
    end

  end

end
