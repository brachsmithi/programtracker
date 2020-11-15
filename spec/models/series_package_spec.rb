require 'rails_helper'

RSpec.describe SeriesPackage, type: :model do

  subject {
    described_class.new(series: create(:series), package: create(:package))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a series" do
    subject.series = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a package" do
    subject.package = nil
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
    it { should belong_to(:package) }
    it { should belong_to(:series) }
  end

end
