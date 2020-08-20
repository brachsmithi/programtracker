require 'rails_helper'

RSpec.describe DiscsHelper, type: :helper do
  
  describe 'display_name' do
  
    it 'should use the first feature entered when there is no sequence' do
      disc = create(:disc)
      program1 = create(:program, name: 'Beach Party')
      program2 = create(:program, name: 'Beach Blanket Bingo')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'FEATURE')
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'FEATURE')
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(helper.display_name(disc)).to eq 'Beach Party'
    end

    it 'should use the sequence number to find the first feature' do
      disc = create(:disc)
      program1 = create(:program, name: 'Beach Party')
      program2 = create(:program, name: 'Beach Blanket Bingo')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'FEATURE', sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'FEATURE', sequence: 1)
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(helper.display_name(disc)).to eq 'Beach Blanket Bingo'
    end

    it 'should use the package name when there are no features' do
      disc = create(:disc)
      program1 = create(:program, name: 'The Boxing Cats')
      program2 = create(:program, name: 'Automated Hat Maker and Meat Grinder')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'SHORT', sequence: 2)
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'SHORT', sequence: 1)
      package = create(:package, name: 'Silent Shorts')
      create(:disc_package, disc_id: disc.id, package_id: package.id)

      expect(helper.display_name(disc)).to eq 'Silent Shorts'
    end

    it 'should use the first program when there are no features or package' do
      disc = create(:disc)
      program1 = create(:program, name: 'Making of Lord of the Rings')
      program2 = create(:program, name: 'Behind the Scenes')
      create(:disc_program, disc_id: disc.id, program_id: program1.id, program_type: 'BONUS')
      create(:disc_program, disc_id: disc.id, program_id: program2.id, program_type: 'BONUS')

      expect(helper.display_name(disc)).to eq 'Making of Lord of the Rings'
    end

    it 'should mark as empty when all else fails' do
      disc = create(:disc)

      expect(helper.display_name(disc)).to eq '--No Programs--'
    end

  end

end
