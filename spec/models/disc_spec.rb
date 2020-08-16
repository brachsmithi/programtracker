require 'rails_helper'

RSpec.describe Disc, :type => :model do
  subject {
    location = create(:default_location)
    described_class.new(format: 'DVD', state: 'UNWATCHED', location: location)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a format" do
    subject.format = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with unknown format" do
    subject.format = '38mm'
    expect(subject).to_not be_valid
  end

  Disc::FORMATS.each do |po|
    it "is valid with format #{po}" do
      subject.format = po
      expect(subject).to be_valid
    end
  end

  it "is not valid without a state" do
    subject.state = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with unknown state" do
    subject.state = 'OHIO'
    expect(subject).to_not be_valid
  end

  Disc::STATES.each do |po|
    it "is valid with state #{po}" do
      subject.state = po
      expect(subject).to be_valid
    end
  end

  it "should set a default location" do
    subject.location = nil
    subject.save
    expect(subject.location).to_not be_nil
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