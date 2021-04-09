require 'rails_helper'

RSpec.describe PackagesHelper, type: :helper do
  
  describe 'capsule_program' do
    
    it 'should include the version' do
      program = create(:program, name: 'Carnival of Souls', version: 'Theatrical')
      expect(helper.capsule_program(program)).to eq 'Carnival of Souls (Theatrical)'
    end

    it 'should handle lack of version gracefully' do
      program = create(:program, name: 'Carnival of Souls', version: '')
      expect(helper.capsule_program(program)).to eq 'Carnival of Souls'
    end

  end

  describe 'package_capsule_array' do

    it 'should generate array of sequenced package capsules' do
      wrapper_package = create(:package, name: 'Farscape: The Complete Series')
      contained_package1 = create(:package, name: 'Farscape: The Complete Season One')
      contained_package2 = create(:package, name: 'Farscape: The Complete Season Two')
      program1 = create(:program, name: 'Interviews', version: '')
      program2 = create(:program, name: 'TV Special', version: '')
      location = create(:location, name: 'Bookshelf')
      disc1 = create(:disc, name: 'Season One Recap', format: 'DVD', location: location)
      nil_seq_disc = create(:disc, location: location)
      nil_seq_package = create(:package, name: 'Unlabeled')
      disc2 = create(:disc, format: 'Blu-ray', location: location)
      create(:disc_program, disc: disc1, program: program2, program_type: 'EPISODE', sequence: 1)
      create(:disc_program, disc: disc1, program: program1, program_type: 'BONUS', sequence: 2)
      create(:disc_package, package: wrapper_package, disc: disc1, sequence: 2)
      create(:disc_package, package: wrapper_package, disc: disc2, sequence: 4)
      create(:disc_package, package: wrapper_package, disc: nil_seq_disc, sequence: nil)
      create(:package_package, wrapper_package: wrapper_package, contained_package: contained_package1, sequence: 1)
      create(:package_package, wrapper_package: wrapper_package, contained_package: contained_package2, sequence: 3)
      create(:package_package, wrapper_package: wrapper_package, contained_package: nil_seq_package, sequence: nil)
      expected_nil_seq_package = {
        seq: 0,
        display_capsule: 'Unlabeled',
        path_method: 'package_path',
        id: nil_seq_package.id,
        type: 'Package'
      }
      expected_nil_seq_disc = {
        seq: 0,
        display_capsule: 'Untitled',
        path_method: 'disc_path',
        id: nil_seq_disc.id,
        type: 'DVD',
        contents: []
      }
      expected_package_capsule1 = {
        seq: 1,
        display_capsule: 'Farscape: The Complete Season One',
        path_method: 'package_path',
        id: contained_package1.id,
        type: 'Package'
      }
      expected_disc_capsule1 = {
        seq: 2,
        display_capsule: 'Season One Recap',
        path_method: 'disc_path',
        id: disc1.id,
        type: 'DVD',
        contents: [
          '<a href="/programs/2">TV Special</a>',
          '<a href="/programs/1">Interviews</a>'
        ]
      }
      expected_package_capsule2 = {
        seq: 3,
        display_capsule: 'Farscape: The Complete Season Two',
        path_method: 'package_path',
        id: contained_package2.id,
        type: 'Package'
      }
      expected_disc_capsule2 = {
        seq: 4,
        display_capsule: 'Untitled',
        path_method: 'disc_path',
        id: disc2.id,
        type: 'Blu-ray',
        contents: []
      }
      expected_array = [
        expected_nil_seq_package,
        expected_nil_seq_disc,
        expected_package_capsule1,
        expected_disc_capsule1,
        expected_package_capsule2,
        expected_disc_capsule2
      ]
      expect(helper.package_capsule_array wrapper_package).to eq expected_array
    end

    it 'should handle empty package' do
      package = create(:package, name: 'CSI Season 1')
      expect(helper.package_capsule_array package).to be_empty
    end

  end

end
