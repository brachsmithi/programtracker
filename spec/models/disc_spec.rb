require 'rails_helper'

RSpec.describe Disc, :type => :model do
  subject {
    location = create(:location)
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

  describe 'not_located' do 
    
    it 'should find discs that are not in any location' do
      default_location = create(:location)
      location = create(:location, name: 'Somewhere')

      d1 = create(:disc, format: 'DVD', location_id: default_location.id)
      create(:disc, format: 'Blu-ray', location_id: location.id)
      d3 = create(:disc, format: 'DVD-R', location_id: default_location.id)
      create(:disc, format: 'DVD', location_id: location.id)
      
      lost = Disc.not_located
      
      expect(lost.count).to eq 2
      expect(lost[0].id).to eq d1.id
      expect(lost[1].id).to eq d3.id
    end

  end
  
  describe "associations" do
    it { should belong_to(:location).without_validating_presence }
    it { should have_many(:disc_programs) }
    it { should have_many(:programs) }
    it { should have_one(:disc_package) }
    it { should have_one(:package) }
    it { should have_many(:series_discs) }
    it { should accept_nested_attributes_for(:disc_programs) }
    it { should accept_nested_attributes_for(:disc_package) }
    it { should accept_nested_attributes_for(:series_discs) }
    
    it "should reject disc program without program set" do
      subject.update(disc_programs_attributes:[{'program_id': ''}])
      expect(subject.programs).to be_empty
    end

    it "should reject disc package without package set" do
      subject.update(disc_package_attributes:{'package_id': ''})
      expect(subject.package).to be_nil
    end

    it "should reject series disc without series set" do
      subject.update(series_discs_attributes:[{'series_id': ''}])
      expect(subject.series_discs).to be_empty
    end

    it 'should allow deletion of disc program' do
      subject.save
      dp = create(:disc_program, disc: subject, program: create(:program))
      subject.update(disc_programs_attributes:[{id: dp.id, _destroy: true}])
      expect(subject.disc_programs).to be_empty
    end

  end

end