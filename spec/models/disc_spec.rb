require 'rails_helper'

RSpec.describe Disc, :type => :model do
  subject {
    location = create(:default_location)
    described_class.new(format: 'DVD', state: 'UNWATCHED', location: location)
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a format' do
    subject.format = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with unknown format' do
    subject.format = '38mm'
    expect(subject).to_not be_valid
  end

  Disc::FORMATS.each do |po|
    it "is valid with format #{po}" do
      subject.format = po
      expect(subject).to be_valid
    end
  end

  it 'is not valid without a state' do
    subject.state = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with unknown state' do
    subject.state = 'OHIO'
    expect(subject).to_not be_valid
  end

  Disc::STATES.each do |po|
    it "is valid with state #{po}" do
      subject.state = po
      expect(subject).to be_valid
    end
  end

  it 'should set a default location' do
    subject.location = nil
    subject.save
    expect(subject.location).to_not be_nil
  end

  describe 'display_name' do
    
    it 'should use the first feature entered when there is no sequence' do
      subject.save
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: subject.id, program_id: program1.id, program_type: 'FEATURE')
      create(:disc_program, disc_id: subject.id, program_id: program2.id, program_type: 'FEATURE')
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: subject.id, package_id: package.id)

      expect(subject.display_name).to eq 'Beach Party (1963)'
    end

    it 'should use the sequence number to find the first feature' do
      subject.save
      program1 = create(:program, name: 'Beach Party', year: '1963')
      program2 = create(:program, name: 'Beach Blanket Bingo', year: '1965')
      create(:disc_program, disc_id: subject.id, program_id: program1.id, program_type: 'FEATURE', sequence: 2)
      create(:disc_program, disc_id: subject.id, program_id: program2.id, program_type: 'FEATURE', sequence: 1)
      package = create(:package, name: 'Beach Movies')
      create(:disc_package, disc_id: subject.id, package_id: package.id)

      expect(subject.display_name).to eq 'Beach Blanket Bingo (1965)'
    end

    it 'should use the package name when there are no features' do
      subject.save
      program1 = create(:program, name: 'The Boxing Cats')
      program2 = create(:program, name: 'Automated Hat Maker and Meat Grinder')
      create(:disc_program, disc_id: subject.id, program_id: program1.id, program_type: 'SHORT', sequence: 2)
      create(:disc_program, disc_id: subject.id, program_id: program2.id, program_type: 'SHORT', sequence: 1)
      package = create(:package, name: 'Silent Shorts')
      create(:disc_package, disc_id: subject.id, package_id: package.id)

      expect(subject.display_name).to eq 'Silent Shorts'
    end

    it 'should use the first program when there are no features or package' do
      subject.save
      program1 = create(:program, name: 'Making of Lord of the Rings', year: '2004')
      program2 = create(:program, name: 'Behind the Scenes', year: '2002')
      create(:disc_program, disc_id: subject.id, program_id: program1.id, program_type: 'BONUS')
      create(:disc_program, disc_id: subject.id, program_id: program2.id, program_type: 'BONUS')

      expect(subject.display_name).to eq 'Making of Lord of the Rings (2004)'
    end

    it 'should mark as empty when all else fails' do
      expect(subject.display_name).to eq '--No Programs--'
    end

  end

  describe 'title_sort_value' do
    
    it 'should use display name' do
      subject.save
      program = create(:program, name: 'Alien', year: '1979')
      create(:disc_program, disc_id: subject.id, program_id: program.id, program_type: 'FEATURE')
      expect(subject.title_sort_value).to eq 'alien (1979)'
    end

    it 'should remove preceding article a' do
      subject.save
      program = create(:program, name: 'A Simple Plan', year: '1998')
      create(:disc_program, disc_id: subject.id, program_id: program.id, program_type: 'FEATURE')
      expect(subject.title_sort_value).to eq 'simple plan (1998)'
    end

    it 'should remove preceding article an' do
      subject.save
      program = create(:program, name: 'An Ordinary Life', year: '2045')
      create(:disc_program, disc_id: subject.id, program_id: program.id, program_type: 'FEATURE')
      expect(subject.title_sort_value).to eq 'ordinary life (2045)'
    end

    it 'should remove preceding article the' do
      subject.save
      program = create(:program, name: 'The Bat', year: '1926')
      create(:disc_program, disc_id: subject.id, program_id: program.id, program_type: 'FEATURE')
      expect(subject.title_sort_value).to eq 'bat (1926)'
    end

  end

  describe 'not_located' do 
    
    it 'should find discs that are not in any location' do
      default_location = create(:default_location)
      location = create(:default_location, name: 'Somewhere')

      d1 = create(:disc, format: 'DVD', location_id: default_location.id)
      d2 = create(:disc, format: 'Blu-ray', location_id: location.id)
      d3 = create(:disc, format: 'DVD-R', location_id: default_location.id)
      d4 = create(:disc, format: 'DVD', location_id: location.id)
      
      lost = Disc.not_located
      
      expect(lost.count).to eq 2
      expect(lost[0].id).to eq d1.id
      expect(lost[1].id).to eq d3.id
    end

  end
  
  describe "associations" do
    it { should belong_to(:location).without_validating_presence }
    it { should have_many(:disc_programs).without_validating_presence }
    it { should have_many(:programs).without_validating_presence }
    it { should have_one(:disc_package).without_validating_presence }
    it { should have_one(:package).without_validating_presence }
    it { should accept_nested_attributes_for(:disc_programs) }
    it { should accept_nested_attributes_for(:disc_package) }
    
    it "should reject disc program without program set" do
      subject.update(disc_programs_attributes:[{'program_id': ''}])
      expect(subject.programs).to be_empty
    end
    it "should reject disc package without package set" do
      subject.update(disc_package_attributes:{'package_id': ''})
      expect(subject.package).to be_nil
    end
  end

end