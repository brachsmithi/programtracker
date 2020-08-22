require 'rails_helper'

RSpec.describe DiscsHelper, type: :helper do
  
  describe 'sort_discs' do
    
    it 'should sort by display name' do
      location = create(:default_location)

      disc1 = create(:disc, location: location)
      program1 = create(:program, name: 'Beach Party')
      program2 = create(:program, name: 'Beach Blanket Bingo')
      create(:disc_program, disc_id: disc1.id, program_id: program1.id, program_type: 'FEATURE')
      create(:disc_program, disc_id: disc1.id, program_id: program2.id, program_type: 'FEATURE')
      package1 = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc1.id, package_id: package1.id)
      # Beach Party

      disc2 = create(:disc, location: location)
      program3 = create(:program, name: 'Aliens')
      program4 = create(:program, name: 'Alien')
      create(:disc_program, disc_id: disc2.id, program_id: program3.id, program_type: 'FEATURE', sequence: 2)
      create(:disc_program, disc_id: disc2.id, program_id: program4.id, program_type: 'FEATURE', sequence: 1)
      package2 = create(:package, name: 'Alien Double Feature')
      create(:disc_package, disc_id: disc2.id, package_id: package2.id)
      # Alien

      disc3 = create(:disc, location: location)
      program5 = create(:program, name: 'The Boxing Cats')
      program6 = create(:program, name: 'Automated Hat Maker and Meat Grinder')
      create(:disc_program, disc_id: disc3.id, program_id: program5.id, program_type: 'SHORT', sequence: 2)
      create(:disc_program, disc_id: disc3.id, program_id: program6.id, program_type: 'SHORT', sequence: 1)
      package3 = create(:package, name: 'Silent Shorts')
      create(:disc_package, disc_id: disc3.id, package_id: package3.id)
      # Silent Shorts

      disc4 = create(:disc, location: location)
      program7 = create(:program, name: 'Making of Lord of the Rings')
      program8 = create(:program, name: 'Behind the Scenes')
      create(:disc_program, disc_id: disc4.id, program_id: program7.id, program_type: 'BONUS')
      create(:disc_program, disc_id: disc4.id, program_id: program8.id, program_type: 'BONUS')
      # Making of Lord of the Rings

      disc5 = create(:disc, location: location)
      # --No Programs--

      sorted = helper.sort_discs [disc1, disc2, disc3, disc4, disc5]

      expect(sorted[0]).to be disc5
      expect(sorted[1]).to eq disc2
      expect(sorted[2]).to eq disc1
      expect(sorted[3]).to eq disc4
      expect(sorted[4]).to eq disc3
    end

    it 'should ignore preceeding articles' do
      location = create(:default_location)
      
      disc1 = create(:disc, location: location)
      program1 = create(:program, name: 'A Girl Walks Home Alone at Night')
      create(:disc_program, disc_id: disc1.id, program_id: program1.id, program_type: 'FEATURE')

      disc2 = create(:disc, location: location)
      program2 = create(:program, name: 'The Bat')
      create(:disc_program, disc_id: disc2.id, program_id: program2.id, program_type: 'FEATURE')

      disc3 = create(:disc, location: location)
      program3 = create(:program, name: 'An Unseen Enemy')
      create(:disc_program, disc_id: disc3.id, program_id: program3.id, program_type: 'FEATURE')

      sorted = helper.sort_discs [disc1, disc2, disc3]

      expect(sorted[0]).to be disc2
      expect(sorted[1]).to eq disc1
      expect(sorted[2]).to eq disc3
    end

  end

end
