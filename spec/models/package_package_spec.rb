require 'rails_helper'

RSpec.describe PackagePackage, type: :model do

  subject {
    described_class.new(wrapper_package: create(:package, name: 'Outer'), contained_package: create(:package, name: 'Inner'))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a wrapper package" do
    subject.wrapper_package = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a contained package" do
    subject.contained_package = nil
    expect(subject).to_not be_valid
  end

  describe 'safe_sequence' do
    
    it 'should return sequence if positive' do
      subject.sequence = 1
      expect(subject.safe_sequence).to eq 1
    end

    it 'should return 0 if nil' do
      subject.sequence = nil
      expect(subject.safe_sequence).to eq 0
    end

  end
  
  describe "associations" do
    it { should belong_to(:wrapper_package) }
    it { should belong_to(:contained_package) }
  end

  it 'should invalidate associating a package with itself' do
    subject.contained_package = subject.wrapper_package
    expect(subject).to_not be_valid
  end

end
