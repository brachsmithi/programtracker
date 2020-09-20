require 'rails_helper'

RSpec.describe SeriesSeries, type: :model do

  subject {
    described_class.new(wrapper_series: create(:series, name: 'Outer'), contained_series: create(:series, name: 'Inner'))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a wrapper series" do
    subject.wrapper_series = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a contained seried" do
    subject.contained_series = nil
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
    it { should belong_to(:wrapper_series) }
    it { should belong_to(:contained_series) }
  end

  it 'should invalidate associating a series with itself' do
    subject.contained_series = subject.wrapper_series
    expect(subject).to_not be_valid
  end

end
